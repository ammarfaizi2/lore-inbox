Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbWJRRdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWJRRdO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWJRRdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:33:14 -0400
Received: from sccrmhc13.comcast.net ([204.127.200.83]:15512 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1161147AbWJRRdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:33:13 -0400
Message-ID: <45366556.7010907@comcast.net>
Date: Wed, 18 Oct 2006 13:33:10 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
Subject: nobody cared about via irq
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm not sure if anyone here cares either but... Ubuntu Edgy.  I think I
reported this problem to Ubuntu a while back, then it went away, now
it's back; not sure though.  CC'd them too.

Linux icebox 2.6.17-10-generic #2 SMP Fri Oct 6 00:36:14 UTC 2006 i686
GNU/Linux



[18142714.092000] agpgart: Found an AGP 3.0 compliant device at
0000:00:00.0.
[18142714.092000] agpgart: Xorg tried to set rate=x12. Setting to AGP3
x8 mode.
[18142714.092000] agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x
mode
[18142714.092000] agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x
mode
[18142714.652000] irq 201: nobody cared (try booting with the "irqpoll"
option)
[18142714.652000]  <c01499b4> __report_bad_irq+0x24/0x80  <c0149aad>
note_interr
upt+0x9d/0x270
[18142714.652000]  <c0149333> handle_IRQ_event+0x33/0x60  <c0149458>
__do_IRQ+0x
f8/0x110
[18142714.652000]  <c0105c89> do_IRQ+0x19/0x30  <c010408a>
common_interrupt+0x1a
/0x20
[18142714.652000]  <c0102080> default_idle+0x0/0x60  <c01020aa>
default_idle+0x2
a/0x60
[18142714.652000]  <c0102122> cpu_idle+0x42/0xb0  <c03f07a1>
start_kernel+0x321/
0x3a0
[18142714.652000]  <c03f0210> unknown_bootoption+0x0/0x270
[18142714.652000] handlers:
[18142714.652000] [<f8e31490>] (via_driver_irq_handler+0x0/0x1d0 [via])
[18142714.652000] Disabling IRQ #201


- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRTZlUAs1xW0HCTEFAQJi1g//ZXy+qMzGR+dPI57ggIMOAm3YcJgwnQb3
nrZLNfJyUqzQ0Bfn5ruL3S1zG9BxNyzbPDmlHK2ngS8DZjqse6Sk7tYeDsD100UT
H204bgtCpZ+/h53p7uTW5KKzhe8hBnlrwEjXCoCnY0sgFf0t02u71eeplObXcVY5
Y5lKcyctipr9BLQrQHtrHQSdJznWTkcUyrc5R6t0Xps9pcVoRQPi5/3HHyhmYsbf
Ws2+jjTAzt25zBV0d6iAh/ZP7pNwUkGa1TEIOaGftH5zAA4zbWjmYThc5c1WmGVG
q85QlpwutujoBHbXrEPx8KH60lbaNskoiRRae/6LjxTVKP/rC8g5MnpvwlIWjEOA
dw8BuEFy7j/BZgq+yEnadhlx53yhAyxPgk5Fu8yYoCiBa2ykZmwiP0yUNVtSKPGw
Arvl/AuOkBXkkhWUpYC8qA8tH27I71AI3h67A9GGKW/Xe9oCjYaneJdgW7TczWUL
5GdqibjSty8tQJDLZyeyxLXvMrVv7NI2cqCzj1Wegu1HhGV8gxjG/xt3XoVRWBNg
dJjDerSQQ+EiLq58gKvEwzFomP2B/QAC2ySwjUPZuWHugZ1eqKfRpdyXv05pN8nB
z6b9jsqzpzaCvNPplskHuFd/ozMKAYMumTT8I/hQx/MeFeiutfoU3tz9LOs9l5/p
GGLVJkOUJsk=
=Em8x
-----END PGP SIGNATURE-----
