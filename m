Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281249AbRKPIsH>; Fri, 16 Nov 2001 03:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281250AbRKPIr5>; Fri, 16 Nov 2001 03:47:57 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:7808 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281249AbRKPIrp>; Fri, 16 Nov 2001 03:47:45 -0500
Message-ID: <005201c16e7b$3f43b840$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] NWFS NetWare File System for Linux 2.4.14 
Date: Fri, 16 Nov 2001 01:46:56 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The NetWare File System (NWFS) has been resurrected due to several requests
from some very large Linux supporters who are doing large scale migration of
NetWare to Linux.  NWFS for 2.4.14 will be available tommorrow afternoon at
ftp.timpanogas.org and ftp.utah-nac.org.  The code is being tested tonight,
and will be posted tommorrow.  NWFS is being transferred to the Utah Native
American Church servers from this point forward for maintenance and bug
fixes.  Please direct bug fixes and questions to jmerkey@utah-nac.org.

The primary FTP servers for timpanogas.org will be transferred over to the
Utah Native American Church this month, so please direct your downloads to
this site in the future.  NWFS will be available from ftp.utah-nac.org
(peyote not included) :-)

This version contains hundreds of fixes, but please do not enable the page
cache code, as it is severely broken.  When and if Linux 2.5 actually
implements variable sector IO requests (which do not have to be aligned on
512,1024, etc. boundries) the page cache code will be enabled in NWFS.  This
is probably a 2.5 feature.  NWFS has been tested on Fibre Channel and 3Ware
controllers, and the Linux RAID, and all appear to work well.

This version is dedicated to Mr. Jack Messman and Mr. Larry Sonsini in
sincere thanks and appreciation for firing Dr. Eric Schmidt from the Novell
Board of Directors, an action that was long overdue.  Perhaps with the
departure Dr. Schmidt, Novell will start becoming more Linux friendly and
customer focused.

Do-na-da Go-hv-e

Wa-do

Jeff Merkey
TRG/Utah NAC
Waya Ge-tlv-hv-s-di

