Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129392AbQK1AGa>; Mon, 27 Nov 2000 19:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129429AbQK1AGV>; Mon, 27 Nov 2000 19:06:21 -0500
Received: from cliff.i-plus.net ([209.100.20.42]:17423 "HELO cliff.i-plus.net")
        by vger.kernel.org with SMTP id <S129392AbQK1AGG>;
        Mon, 27 Nov 2000 19:06:06 -0500
From: Lee Brown <leejr@i-plus.net>
To: linux-kernel@vger.kernel.org
Subject: 9750 vs. blade3D gives freaky ttyS3 problem)
Date: Mon, 27 Nov 2000 18:19:09 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00112718343300.00131@darkstar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear smart people on the kernel mailing list:

I have celeron 300 MHz box (overcl'ked to 450)
I am running 2.4 test11.
ISA PnP enabled.
I am using the fbconsole(VESA VGA).
I have a tried and true serial modem.

When I put in a Trident 975AGP the /dev/ttyS3 (modem)  works fine. I can tell
this because the response to minicom is snappy and KPPP works(after I startx).

When I remove the 975 and install my new Trident Blade3D (9880) I have
different results.  When I run minicom
1)  The initialization box appears.
2) The box then disappears (as it supposed to)
3) I wait several seconds
4)  The initial string _crawls_ across the screen and finally gives me OK

Why am I getting sluggish (to the point where I can't use the modem) response
with this second setup?  the 975 and the Blade3D are very similar I imagine.
And what is the connection between a video card and the serial port?

If you need any more system info I'll be glad to give it.

(Please CC me as I am not on the List)
Thank You Ahead.
-- 
Lee Brown Jr.
leejr@i-plus.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
