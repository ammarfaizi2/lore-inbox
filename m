Return-Path: <linux-kernel-owner+ralf=40uni-koblenz.de@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S316584AbSEWM5c>; Thu, 23 May 2002 08:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S316609AbSEWM5b>; Thu, 23 May 2002 08:57:31 -0400
Received: from YahooBB225162042.bbtec.net ([43.225.162.42]:38663 "EHLO smtp1") by vger.kernel.org with ESMTP id <S316584AbSEWM5a>; Thu, 23 May 2002 08:57:30 -0400
Message-ID: <001301c20259$c7d33dd0$0201a8c0@pjutaro1>
From: "Takuya Satoh" <taka0038@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Subject: Unresolved symbols with 2.4.19-pre8-ac5
Date: Thu, 23 May 2002 22:00:14 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting these related to vmalloc_to_page:

/lib/modules/2.4.19-pre8-ac5/kernel/drivers/char/drm/radeon.o: unresolved
symbol vmalloc_to_page
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/char/drm/radeon.o: insmod
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/char/drm/radeon.o failed
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/char/drm/radeon.o: insmod radeon
failed

May 23 18:13:24 server09 depmod: depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/char/drm/mga.o
May 23 18:13:24 server09 depmod: depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/char/drm/radeon.o
May 23 18:13:24 server09 depmod: depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/usb/ov511.o
May 23 18:13:24 server09 depmod: depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/usb/pwc.o
May 23 18:13:24 server09 depmod: depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/usb/se401.o
May 23 18:13:24 server09 depmod: depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/usb/stv680.o
May 23 18:13:24 server09 depmod: depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/usb/usbvideo.o
May 23 18:13:24 server09 depmod: depmod: *** Unresolved symbols in
/lib/modules/2.4.19-pre8-ac5/kernel/drivers/usb/vicam.o
May 23 18:13:24 server09 rc.sysinit: Finding module dependencies:  failed

Taka


