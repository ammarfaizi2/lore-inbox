Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266387AbSKKLzr>; Mon, 11 Nov 2002 06:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266409AbSKKLzr>; Mon, 11 Nov 2002 06:55:47 -0500
Received: from port-213-148-149-130.reverse.qsc.de ([213.148.149.130]:4904
	"EHLO eumucln01.mscsoftware.com") by vger.kernel.org with ESMTP
	id <S266387AbSKKLzq>; Mon, 11 Nov 2002 06:55:46 -0500
Message-ID: <3DCF7CBA.D75C297C@mscsoftware.com>
Date: Mon, 11 Nov 2002 10:47:38 +0100
From: Martin Knoblauch <"martin.knoblauch "@mscsoftware.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre10-ac2-mkn i686)
X-Accept-Language: en
MIME-Version: 1.0
To: manish@Zambeel.com
CC: linux-kernel@vger.kernel.org
Subject: RE: Memory performance on Serverworks GC-LE based system poor?
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.2; AVE: 6.16.0.0; VDF: 6.16.0.15
	 at mailmuc has not found any known virus in this email.
X-MIMETrack: Itemize by SMTP Server on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 11/11/2002 12:57:59 PM,
	Serialize by Router on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 11/11/2002 12:58:07 PM,
	Serialize complete at 11/11/2002 12:58:07 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> You must have done this, but just wanted to confirm. Did you check the Front
> Side Bus speed in the BIOS?
> 
> Thanks
> Manish
> 

 Actually, we did check a lot of things, but did not see settings for
the FSB. What would the correct speed be?

Thanks
Martin

> -----Original Message-----
> From: Martin Knoblauch [mailto:knobi@knobisoft.de]
> Sent: Sunday, November 10, 2002 4:30 PM
> To: linux-kernel@vger.kernel.org
> Subject: Memory performance on Serverworks GC-LE based system poor?
> 
> Hi,
> 
>  I have experienced extreme low STREAMS numbers (about 600 MB/sec for Triad)
> 
> on two dual CPU systems based on the ServerWorks GC-LE chipset (SuperMicro
> P4DLR+ mainboard). Both systems had 2x2.4 GHz XEONs, 4GB of DDR memory and
> were running kernel 2.4.18. I would usually expect STREAMS numbers of about
> 2000 MB/sec for this kind of systems.
> 
> Does this ring any bells?
> 
> Martin
>
