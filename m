Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTFAFwm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 01:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTFAFwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 01:52:42 -0400
Received: from haw-66-102-130-200.vel.net ([66.102.130.200]:6872 "HELO
	mx100.mysite4now.com") by vger.kernel.org with SMTP id S261294AbTFAFwk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 01:52:40 -0400
From: Udo Hoerhold <maillists@goodontoast.com>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21rc6-ac1
Date: Sun, 1 Jun 2003 02:05:08 -0400
User-Agent: KMail/1.5.2
References: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
In-Reply-To: <200305311153.h4VBrNi21640@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306010205.09012.maillists@goodontoast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 May 2003 07:53 am, Alan Cox wrote:
> Linux 2.4.21rc6-ac1

I'm seeing these errors, and it doesn't look like anyone else has reported 
them.  I didn't see them in 2.4.21-rc5-ac3, the last time I compiled.

depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/at1700.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/atp.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/de4x5.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/depca.o
depmod:         crc32_le
depmod:         bitreverse
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/dmfe.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/epic100.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/ewrk3.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/smc9194.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/starfire.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/sundance.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/sungem.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/sunhme.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/tulip/tulip.o
depmod:         crc32_le
depmod:         bitreverse
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/net/via-rhine.o
depmod:         crc32_le
depmod:         bitreverse
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/usb/catc.o
depmod:         crc32_le
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-rc6-ac1/kernel/drivers/usb/usbnet.o
depmod:         crc32_le
make: *** [_modinst_post] Error 1

