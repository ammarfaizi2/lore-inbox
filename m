Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293354AbSCFIT5>; Wed, 6 Mar 2002 03:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293352AbSCFITs>; Wed, 6 Mar 2002 03:19:48 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:21132 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S293347AbSCFITh>; Wed, 6 Mar 2002 03:19:37 -0500
Message-ID: <XFMail.20020306084829.R.Oehler@GDAmbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Wed, 06 Mar 2002 08:48:29 +0100 (MET)
From: Ralf Oehler <R.Oehler@GDAmbH.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Scsi <linux-scsi@vger.kernel.org>
Subject: Support for sectorsizes > 4KB ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, List

In the not-so-far future there will occure MO media on the market with
40 to 120 Gigabytes of capacity and sectorsizes of 8 KB and maybe more.
It's called "UDO" technology.

Is there any way to support block devices with sectors larger than 4KB ?

Regards,
        Ralf


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
