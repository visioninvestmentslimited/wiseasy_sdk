package com.visionpay.wiseasy_sdk.wisepos

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Bundle
import android.util.Log
import com.visionpay.wiseasy_sdk.BarcodeType
import com.visionpay.wiseasy_sdk.FlutterError
import com.visionpay.wiseasy_sdk.PrinterAlign
import com.visionpay.wiseasy_sdk.PrinterTextInfo
import com.visionpay.wiseasy_sdk.WisePosPrinterChannel
import com.wisepos.smartpos.WisePosException
import com.wisepos.smartpos.errorcode.WisePosErrorCode
import com.wisepos.smartpos.printer.Align
import com.wisepos.smartpos.printer.Printer
import com.wisepos.smartpos.printer.PrinterListener
import com.wisepos.smartpos.printer.TextInfo

private const val TAG = "WisePosPrinter"

class WisePosPrinter(private val printer: Printer) : WisePosPrinterChannel {

    override fun initialize() {
        val result = printer.initPrinter()
        if (result != WisePosErrorCode.ERR_SUCCESS) {
            throw FlutterError(
                result.toString(),
                "Failed to initialize Printer: $result"
            )

        }
    }

    override fun printSample() {
        try {
            var ret: Int = printer.initPrinter() //Initializing the printer.
            if (ret != WisePosErrorCode.ERR_SUCCESS) {
                Log.e(TAG, "initPrinter failed $ret")
                return
            }
            ret = printer.setGrayLevel(2) //Set the printer gray value.
            if (ret != WisePosErrorCode.ERR_SUCCESS) {
                Log.e(TAG, "setGrayLevel failed $ret")
                return
            }
            //Gets the current status of the printer
            val map: Map<String?, Any?>? =
                printer.printerStatus
            if (map == null) {
                Log.e(TAG, "getStatus failed")
                return
            }
            //Gets whether the printer is out of paper from the map file.
            if ((map["paper"].toString().toInt()) == 1) {
                Log.e(TAG, "IsHavePaper = false\n")
                return
            } else {
                Log.e(TAG, "IsHavePaper = true\n")
            }

            //When printing text information, the program needs to set the printing font. The current setting is the default font.
            val bundle1 = Bundle()
            bundle1.putString("font", "DEFAULT")
            printer.setPrintFont(bundle1)
            val textInfo = TextInfo()
            /// textInfo.setAlign(PRINT_STYLE_CENTER)
            textInfo.setFontSize(32)
            printer.setLineSpacing(1)
            textInfo.setText("www.wiseasy.com")
            printer.addSingleText(textInfo)
            textInfo.setFontSize(24)
            textInfo.setText("--------------------------------------------")
            printer.addSingleText(textInfo)
            // textInfo.setAlign(PRINT_STYLE_LEFT)
            textInfo.setText("Meal Package:KFC $100 coupons")
            printer.addSingleText(textInfo)
            textInfo.setText("Selling Price:$90")
            printer.addSingleText(textInfo)
            textInfo.setText("Merchant Name:KFC（ZS Park）")
            printer.addSingleText(textInfo)
            textInfo.setText("Payment Time:17/3/29 9:27")
            printer.addSingleText(textInfo)
            //  textInfo.setAlign(PRINT_STYLE_CENTER)
            textInfo.setText("--------------------------------------------")
            printer.addSingleText(textInfo)
            //  textInfo.setAlign(PRINT_STYLE_LEFT)
            textInfo.setText("NO. of Coupons:5")
            printer.addSingleText(textInfo)
            textInfo.setText("Total Amount:$450")
            printer.addSingleText(textInfo)
            textInfo.setText("SN:1234 4567 4565,")
            printer.addSingleText(textInfo)
            val printerOption = Bundle()
            //Start printing
            printer.startPrinting(printerOption, object : PrinterListener {
                override fun onError(i: Int) {
                    Log.e(TAG, "startPrinting failed errCode = $i")
                }

                override fun onFinish() {
                    Log.e(TAG, "print success\n")
                    try {
                        //After printing, Feed the paper.
                        printer.feedPaper(30)
                    } catch (e: WisePosException) {
                        e.printStackTrace()
                    }
                }

                override fun onReport(i: Int) {
                    //The callback method is reserved and does not need to be implemented
                }
            })
        } catch (e: Exception) {
            e.printStackTrace()
            Log.e(TAG, "print failed$e\n")
        }
    }

    override fun startPrinting(options: Map<String, Any>, callback: (Result<Unit>) -> Unit) {
        printer.startPrinting(options.toBundle(), object : PrinterListener {
            override fun onError(errorCode: Int) {
                callback(Result.failure(FlutterError("Failed", "Failed with Error: $errorCode")))
            }

            override fun onFinish() {
                callback(Result.success(Unit))
            }

            override fun onReport(i: Int) {
                Log.d(TAG, "PrintReport: $i")
            }
        })
    }

    override fun addSingleText(textInfo: PrinterTextInfo) {
        printer.addSingleText(textInfo.toTextInfo())
    }

    override fun addMultiText(textInfoList: List<PrinterTextInfo>) {
        printer.addMultiText(textInfoList.map {
            it.toTextInfo()
        })
    }

    override fun addPicture(align: PrinterAlign, image: ByteArray) {
        printer.addPicture(align.toNative(), image.toBitmap())
    }

    override fun addBarCode(type: BarcodeType, width: Long, height: Long, barcode: String) {
        printer.addBarCode(type.toNative(), width.toInt(), height.toInt(), barcode)
    }

    override fun addQrCode(width: Long, height: Long, qrCode: String) {
        printer.addQrCode(width.toInt(), height.toInt(), qrCode)
    }

    override fun setLineSpacing(spacing: Long) {
        printer.setLineSpacing(spacing.toInt())
    }

    override fun feedPaper(dots: Long) {
        printer.feedPaper(dots.toInt())
    }

    override fun getPrinterStatus(): Map<String, Any> {
        return printer.printerStatus
    }

    override fun setGrayLevel(level: Long): Long {
        return printer.setGrayLevel(level.toInt()).toLong()
    }

    override fun setPrintFont(data: Map<String, Any>) {
        printer.setPrintFont(data.toBundle())
    }

    override fun getPrinterMileage(): Double {
        return printer.printerMileage.toDouble()
    }

    override fun clearPrinterMileage() {
        printer.clearPrinterMileage()
    }


    /// Helper Methods
    private fun PrinterTextInfo.toTextInfo(): TextInfo {
        val info = TextInfo(text)
        info.fontSize = fontSize.toInt()
        info.width = width.toInt()
        info.columnSpacing = columnSpacing.toInt()
        info.align = align.toInt()
        info.setBold(isBold)
        info.setItalic(isItalic)
        info.setWithUnderline(isWithUnderline)
        info.setReverseText(isReverseText)
        return info
    }

    private fun Map<String, Any>.toBundle(): Bundle {
        val bundle = Bundle()
        this.forEach {
            when (val value = it.value) {
                is String -> bundle.putString(it.key, value)
                is Int -> bundle.putInt(it.key, value)
                is Long -> bundle.putLong(it.key, value)
                is Float -> bundle.putFloat(it.key, value)
                is Char -> bundle.putChar(it.key, value)
                else -> Log.e(TAG, "Unsupported BundleValue")
            }
        }
        return bundle
    }

    private fun BarcodeType.toNative(): Int {
        return when (this) {
            BarcodeType.BARCODE_128 -> com.wisepos.smartpos.printer.BarcodeType.BARCODE_TYPE_BARCODE_128
            BarcodeType.PDF_417 -> com.wisepos.smartpos.printer.BarcodeType.BARCODE_TYPE_PDF417
            BarcodeType.BARCODE_39 -> com.wisepos.smartpos.printer.BarcodeType.BARCODE_TYPE_BARCODE_39
        }
    }

    private fun PrinterAlign.toNative(): Int {
        return when (this) {
            PrinterAlign.LEFT -> Align.PRINT_ALIGN_STYLE_LEFT
            PrinterAlign.CENTER -> Align.PRINT_ALIGN_STYLE_CENTER
            PrinterAlign.RIGHT -> Align.PRINT_ALIGN_STYLE_RIGHT
        }
    }

    private fun ByteArray.toBitmap(): Bitmap {
        return BitmapFactory.decodeByteArray(this, 0, this.size)
    }

}