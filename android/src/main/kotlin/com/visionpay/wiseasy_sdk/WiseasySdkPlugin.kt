package com.visionpay.wiseasy_sdk

import android.content.Context
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.os.RemoteException
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import wangpos.sdk4.libbasebinder.Printer
import java.util.concurrent.atomic.AtomicBoolean

private const val TAG = "WiseasySdkPlugin"

class WiseasySdkPlugin : FlutterPlugin, WiseasyPlatformChannel, Runnable {
    private lateinit var mContext: Context
    private var mainThreadHandler: Handler? = null
    private var mPrinter: Printer? = null
    private var initializationThread: Thread? = null
    private val isInitializing = AtomicBoolean(false)

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        WiseasyPlatformChannel.setUp(flutterPluginBinding.binaryMessenger, this)
        mContext = flutterPluginBinding.applicationContext
        mainThreadHandler = Handler(Looper.getMainLooper())
        startPrintThread()
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        mainThreadHandler = null
        dispose()
    }


    fun startPrintThread() {
        initializationThread = object : Thread() {
            override fun run() {
                try {
                    mPrinter = Printer(mContext)
                    val MODEL = Build.MODEL
                    Log.d(TAG, "run: model = $MODEL")
                    if (MODEL.equals("WPOS-MINI", ignoreCase = true) || MODEL.equals(
                            "WPOS-QT",
                            ignoreCase = true
                        )
                    ) {
                        mPrinter!!.setPrintType(1)
                    } else {
                        mPrinter!!.setPrintType(0)
                    }
                } catch (e: RemoteException) {
                    e.printStackTrace()
                }
            }
        }
        initializationThread?.start()
    }


    override fun run() {
        // if (isInitializing.compareAndSet(false, true)) {
        Log.e(TAG, "Running Printer")
        mPrinter = Printer(mContext)
        val model: String = Build.MODEL
        Log.e(TAG, "run: model = $model")
        val printerType = if (model.equals("WPOS-MINI", ignoreCase = true) ||
            model.equals("WPOS-QT", ignoreCase = true)
        ) 1 else 0
        mPrinter?.setPrintType(printerType)
        // }
    }

    override fun initialize(): Long? {
//        if (mPrinter == null) {
//            initializationThread = Thread(this)
//            initializationThread?.start()
//        }
        return mPrinter?.printInit()?.toLong()
    }

    override fun dispose() {
        initializationThread?.interrupt()
        initializationThread = null
        mPrinter?.let {
            try {
                it.printFinish()
            } catch (e: RemoteException) {
                Log.e(TAG, "Error stopping printer", e)
            } finally {
                mPrinter = null
            }
        }
    }

    override fun printSample(): Long? {
        val status = IntArray(1)
        status[0] = -1
        try {
            mPrinter?.printPaper(10)
            mPrinter?.printString("www.wiseasy.com", 25, Printer.Align.CENTER, true, false)
            mPrinter?.printString(
                "北京微智全景信息技术有限公司",
                25,
                Printer.Align.CENTER,
                false,
                false
            )
            mPrinter?.printString("  ", 30, Printer.Align.CENTER, false, false)
            mPrinter?.printString(
                "--------------------------------------------",
                30,
                Printer.Align.CENTER,
                false,
                false
            )
            mPrinter?.printString(
                "Meal Package:KFC $100 coupons",
                25,
                Printer.Align.LEFT,
                false,
                false
            )
            mPrinter?.printString("Selling Price:$90", 25, Printer.Align.LEFT, false, false)
            mPrinter?.printString(
                "Merchant Name:KFC（ZS Park）",
                25,
                Printer.Align.LEFT,
                false,
                false
            )
            mPrinter?.printString("Payment Time:17/3/29 9:27", 25, Printer.Align.LEFT, false, false)
            mPrinter?.printString(
                "--------------------------------------------",
                30,
                Printer.Align.CENTER,
                false,
                false
            )
            mPrinter?.printString("NO. of Coupons:5", 25, Printer.Align.LEFT, false, false)
            mPrinter?.printString("Total Amount:$450", 25, Printer.Align.LEFT, false, false)
            mPrinter?.printString("SN:1234 4567 4565", 25, Printer.Align.LEFT, false, false)
            //default content is too long to wrap
            mPrinter?.printString(
                "the content is too long to wrap the content is too long to wrap",
                25,
                Printer.Align.LEFT,
                false,
                false
            )
            //font style print
            mPrinter?.printStringExt(
                "Default Font",
                0,
                0f,
                1.0f,
                Printer.Font.DEFAULT,
                20,
                Printer.Align.LEFT,
                false,
                false,
                false
            )
            mPrinter?.printStringExt(
                "Default Bold Font ",
                0,
                0f,
                2.0f,
                Printer.Font.DEFAULT_BOLD,
                20,
                Printer.Align.LEFT,
                false,
                false,
                false
            )
            mPrinter?.printStringExt(
                "Monospace Font ",
                0,
                0f,
                1.0f,
                Printer.Font.MONOSPACE,
                20,
                Printer.Align.LEFT,
                false,
                false,
                false
            )
            mPrinter?.printStringExt(
                "Sans Serif Font ",
                0,
                0f,
                3.0f,
                Printer.Font.SANS_SERIF,
                20,
                Printer.Align.LEFT,
                false,
                false,
                false
            )
            mPrinter?.printStringExt(
                "Serif Font ",
                0,
                0f,
                5.0f,
                Printer.Font.SERIF,
                20,
                Printer.Align.LEFT,
                false,
                false,
                false
            )
            //two content left and right in one line
            mPrinter?.print2StringInLine(
                "left",
                "right",
                1.0f,
                Printer.Font.DEFAULT,
                25,
                Printer.Align.LEFT,
                false,
                false,
                false
            )
            var proportionArray = intArrayOf(3, 1, 1, 1)
            var contentArray = arrayOf("Face mask", "1.5", "3.0", "PST")
            Printer.printMultiseriateString(
                proportionArray,
                contentArray,
                25,
                Printer.Align.LEFT,
                false,
                false
            )
            proportionArray = intArrayOf(3, 1, 1, 1)
            contentArray = arrayOf("84 Disinfectant", "1.5", "3.0", "PST")
            Printer.printMultiseriateString(
                proportionArray,
                contentArray,
                25,
                Printer.Align.LEFT,
                false,
                false
            )
            proportionArray = intArrayOf(4, 1, 1)
            contentArray = arrayOf("subtotal", "3.0", "6.0")
            Printer.printMultiseriateString(
                proportionArray,
                contentArray,
                25,
                Printer.Align.LEFT,
                false,
                false
            )

            //default content print
            mPrinter?.printStringExt(
                "COMPLETED SALE TOTAL",
                0,
                0f,
                2.0f,
                Printer.Font.DEFAULT_BOLD,
                33,
                Printer.Align.CENTER,
                true,
                false,
                false
            )
            mPrinter?.printPaper(100)
            mPrinter?.getPrinterStatus(status)
            Log.d(TAG, "testPrintString: status = " + status[0])
        } catch (e: RemoteException) {
            e.printStackTrace()
        }
        return status[0].toLong()
    }

    override fun paperFeed(distance: Long): Long? {
        return mPrinter?.printPaper(distance.toInt())?.toLong()
    }

    override fun printLine(
        text: String,
        fontSize: Long,
        align: PrinterAlign,
        bold: Boolean,
        italic: Boolean,
    ): Long? {
        val alignment = when (align) {
            PrinterAlign.LEFT -> Printer.Align.LEFT
            PrinterAlign.CENTER -> Printer.Align.CENTER
            PrinterAlign.RIGHT -> Printer.Align.RIGHT
        }
        return mPrinter?.printString(text, fontSize.toInt(), alignment, bold, italic)?.toLong()
    }

    override fun stopPrint(): Long? {
        return mPrinter?.printFinish()?.toLong();
    }


}
