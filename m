Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbSLTIz7>; Fri, 20 Dec 2002 03:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266295AbSLTIz7>; Fri, 20 Dec 2002 03:55:59 -0500
Received: from port-213-148-149-130.reverse.qsc.de ([213.148.149.130]:14273
	"EHLO eumucln01.mscsoftware.com") by vger.kernel.org with ESMTP
	id <S266286AbSLTIz6>; Fri, 20 Dec 2002 03:55:58 -0500
Message-ID: <3E02DCC7.53800713@mscsoftware.com>
Date: Fri, 20 Dec 2002 10:03:03 +0100
From: Martin Knoblauch <"martin.knoblauch "@mscsoftware.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-ac1-mkn i686)
X-Accept-Language: en
MIME-Version: 1.0
To: waltabbyh@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: Adaptec 79xx support in 2.4.x
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.2; AVE: 6.17.0.2; VDF: 6.17.0.8
	 at mailmuc has not found any known virus in this email.
X-MIMETrack: Itemize by SMTP Server on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 12/20/2002 09:59:15 AM,
	Serialize by Router on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 12/20/2002 09:59:24 AM,
	Serialize complete at 12/20/2002 09:59:24 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Adaptec 79xx support in 2.4.x
> 
> From: Walt H (waltabbyh@mindspring.com)
> Date: Thu Dec 19 2002 - 23:21:42 EST
> 
>    * Next message: Stephen Satchell: "Re: Saving logs when system is started"
>    * Previous message: Alex Goddard: "Re: depmod errors in 2.5.52-bk"
>    * Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
> 
>   ------------------------------------------------------------------------
> 
> Hello,
> 
> I have a Tyan Thunder K7XPro based server with the onboard AIC7902
> controllers. At the present time, its is running 2.4.19 patched with
> Adaptec's source release for the SCSI support. Adaptec's drivers did not
>   seamlessly integrate into the 2.4.19 kernel. I found an old mail
> stating that support for this chipset would be added eventually. It
> doesn't appear to be added to the 2.4 series yet. Is there something I
> should be concerned about with regards to my server? The overall
> performance and stability seem fine so far, but it is a relatively new
> box with only about 1 month in production - so far so good :)
> 
> According to Justin at Adaptec, the source has been given to both Linus
> and Marcelo. I'd sure like to see it in mainline to avoid having to hack
> it in there as it stands. Thanks.
> 
> -Walt
> 

 I would like to second that request. Those 7902 pop up in a lot of new
motherboards recently and not having them in mailine is a PITA.

 The driver itself seems to be OK, but there seems to be a higher
sensitivity to cabling and drive quality that with U160. I am just now
fighting with some FUJITSU MAP3735NC on a SuperMicro P4DP8-G2
motherboard that only work OK when running at 160 MB/s.


My two Eurocent
Martin
