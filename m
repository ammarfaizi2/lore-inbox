Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290213AbSBFHdu>; Wed, 6 Feb 2002 02:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290192AbSBFHdb>; Wed, 6 Feb 2002 02:33:31 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:1973 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290185AbSBFHdZ>; Wed, 6 Feb 2002 02:33:25 -0500
Message-ID: <XFMail.20020206083210.R.Oehler@GDAmbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E16YCdv-0002ru-00@the-village.bc.nu>
Date: Wed, 06 Feb 2002 08:32:10 +0100 (MET)
From: Ralf Oehler <R.Oehler@GDAmbH.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: one-line-patch against SCSI-Read-Error-BUG()
Cc: <axboe@kernel.org (Jens Axboe)>, <andrea@suse.de (Andrea Arcangeli)>,
        linux-kernel@vger.kernel.org, <linux-scsi@vger.kernel.org (Scsi)>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05-Feb-2002 Alan Cox wrote:
|   > Since at least kernel 2.4.16 there is a BUG() in pci.h,
|   > that crashes the kernel on any attempt to read a SCSI-Sector
|   > from an erased MO-Medium and on any attempt to read
|   > a sector from a SCSI-disk, which returns "Read-Error".
|    
|    Adaptec aic7xxx card ?

Yes. And I only have Adaptecs...    

 --------------------------------------------------------------------------
|  Ralf Oehler                          
|                                       
|  GDA - Gesellschaft fuer Digitale                              _/
|        Archivierungstechnik mbH & CoKG                        _/
|  Ein Unternehmen der Bechtle AG               #/_/_/_/ _/_/_/_/ _/_/_/_/
|                                              _/    _/ _/    _/       _/
|  E-Mail:      R.Oehler@GDAmbH.com           _/    _/ _/    _/ _/    _/
|  Tel.:        +49 6182-9271-23             _/_/_/_/ _/_/_/#/ _/_/_/#/
|  Fax.:        +49 6182-25035                    _/
|  Mail:        GDA, Bensbruchstraﬂe 11,   _/_/_/_/
|               D-63533 Mainhausen      
|  HTTP:        www.GDAmbH.com         
 --------------------------------------------------------------------------

time is a funny concept
