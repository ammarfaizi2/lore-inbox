Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWEPVaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWEPVaM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWEPVaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:30:12 -0400
Received: from mail0.lsil.com ([147.145.40.20]:10221 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932092AbWEPVaK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:30:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Help: strange messages from kernel on IA64 platform
Date: Tue, 16 May 2006 15:30:07 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BD87@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Help: strange messages from kernel on IA64 platform
Thread-Index: AcZ5LoSBlp1Y96GRQ56CVoCjgYIfnwAAPv6Q
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: =?iso-8859-1?Q?=22D=F6hr=2C_Markus_ICC-H=22?= 
	<Markus.Doehr@siegenia-aubi.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 16 May 2006 21:30:07.0863 (UTC) FILETIME=[E75C0870:01C6792F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Tuesday, May 16, 2006 5:20 PM, "Döhr, Markus ICC-H" wrote:
> We have this message too on our main database server; the 
> interesting part
> is, that the application, which triggers this error, is a 
> database (MaxDB)
> and the process name is "kernel"... Just to avoid confusion: 
> look if there's
> an application with such name running on your system.
I quickly looked at the system with 'ps' command.
It seems there is no such process which starting its name with "kernel.." on the system.
Thank you for your comment.

Regards,

> -----Original Message-----
> From: "Döhr, Markus ICC-H" [mailto:Markus.Doehr@siegenia-aubi.com] 
> Sent: Tuesday, May 16, 2006 5:20 PM
> To: Ju, Seokmann; Linux Kernel Mailing List
> Cc: linux-scsi@vger.kernel.org
> Subject: RE: Help: strange messages from kernel on IA64 platform
> 
> > During communication in between application and megaraid 
> > driver via IOCTL, the system displays messages which are not 
> > easy to track down.
> > Following is one of the messages and same messages with 
> > different values are poping up regularly.
> > ---
> > Kernel unaligned access to 0xe00000007f3d80dc ip=0xa0000002000373b1
> > ---
> 
> We have this message too on our main database server; the 
> interesting part
> is, that the application, which triggers this error, is a 
> database (MaxDB)
> and the process name is "kernel"... Just to avoid confusion: 
> look if there's
> an application with such name running on your system.
> 
> 
> Greetz,
> 
> 
> SIEGENIA-AUBI KG
> Informationswesen
>  
> i.A.
>  
> Markus Döhr
> SAP-CC/BC, SAPDB-DBA
> 
> Tel.:	 +49 6503 917-152
> Fax:	 +49 6503 917-7152
> E-Mail: markus.doehr@siegenia-aubi.com
> Internet: http://www.siegenia-aubi.com 
>   
> 
