Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRCIDi6>; Thu, 8 Mar 2001 22:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbRCIDis>; Thu, 8 Mar 2001 22:38:48 -0500
Received: from chmls20.mediaone.net ([24.147.1.156]:35256 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S129712AbRCIDip>; Thu, 8 Mar 2001 22:38:45 -0500
Message-ID: <3AA84F7F.27F5C165@mediaone.net>
Date: Thu, 08 Mar 2001 22:35:27 -0500
From: Ken Hill <khill2@mediaone.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compile errors on 2.4.2-ac16
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by leeloo.zip.com.au id OAA28010

serial.c: In function `wait_for_xmitr':
serial.c:5497: `ASYNC_NO_FLOW' undeclared (first use in this function)
serial.c:5497: (Each undeclared identifier is reported only once
serial.c:5497: for each function it appears in.)
serial.c: In function `serial_console_setup':
serial.c:5666: `ASYNC_NO_FLOW' undeclared (first use in this function)
make[3]: *** [serial.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

ı:.Ë›±Êâmçë¢kaŠÉb²ßìzwm…ébïîË›±Êâmébìÿ‘êçz_âØ^n‡r¡ö¦zËëh™¨è­Ú&£ûàz¿äz¹Ş—ú+€Ê+zf£¢·hšˆ§~†­†Ûiÿÿïêÿ‘êçz_è®æj:+v‰¨ş)ß£ømšSåy«­æ¶…­†ÛiÿÿğÃí»è®å’i
