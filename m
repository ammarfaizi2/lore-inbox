Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288544AbSADId1>; Fri, 4 Jan 2002 03:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288545AbSADIdR>; Fri, 4 Jan 2002 03:33:17 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:28068 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S288544AbSADIdH>; Fri, 4 Jan 2002 03:33:07 -0500
Message-ID: <XFMail.20020104093136.R.Oehler@GDImbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <19996.1010086392@ocs3.intra.ocs.com.au>
Date: Fri, 04 Jan 2002 09:31:36 +0100 (MET)
From: R.Oehler@GDImbH.com
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: kernel 2.4.17 crashes on SCSI-errors
Cc: Jens Axboe <axboe@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03-Jan-2002 Keith Owens wrote:
> On Thu, 03 Jan 2002 14:39:02 +0100 (MET), 
> R.Oehler@GDImbH.com wrote:
>>Ksymoops was not possible, because after rebooting the 
>>memory/module-layout had changed. (Or is there a trick
>>I don't know?)
> 
> /var/log/ksymoops.  man insmod, look for ksymoops assistance.
> 

Thanks a lot, I'll try it for the next crash.
But for now, I think, the output of the SGI debugger I sent
to the list shows the same.

kernel BUG at /usr/src/linux-2.4.17-Dbg/include/asm/pci.h:147!
from [aic7xxx]ahc_linux_run_device_queue+0x39d



Is there anything more I can do?
Regards,
        Ralf



 -----------------------------------------------------------------
|  Ralf Oehler
|  GDI - Gesellschaft fuer Digitale Informationstechnik mbH
|
|  E-Mail:      R.Oehler@GDImbH.com
|  Tel.:        +49 6182-9271-23 
|  Fax.:        +49 6182-25035           
|  Mail:        GDI, Bensbruchstraﬂe 11, D-63533 Mainhausen
|  HTTP:        www.GDImbH.com
 -----------------------------------------------------------------

time is a funny concept

