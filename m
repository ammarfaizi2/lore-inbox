Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135296AbREFKFX>; Sun, 6 May 2001 06:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135321AbREFKFN>; Sun, 6 May 2001 06:05:13 -0400
Received: from babylon5.babcom.com ([216.36.71.34]:655 "EHLO
	babylon5.babcom.com") by vger.kernel.org with ESMTP
	id <S135296AbREFKFC>; Sun, 6 May 2001 06:05:02 -0400
Date: Sun, 6 May 2001 03:05:00 -0700
From: Phil Stracchino <alaric@babcom.com>
To: Linux-KERNEL <linux-kernel@vger.kernel.org>
Subject: CDROM troubles
Message-ID: <20010506030500.A26278@babylon5.babcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-No-Archive: Yes
X-PGP-Fingerprint: 2105 C6FC 945D 2A7A 0738  9BB8 D037 CE8E EFA1 3249
X-PGP-Key-FTP-URL: ftp://ftp.babcom.com/pub/pgpkeys/alaric.asc
X-PGP-Key-HTTP-URL: http://www.babcom.com/alaric/pgp.html
X-Copyright: This message may not be reproduced, in part or in whole, for any commercial purpose without prior written permission.  Prior permission for securityfocus.com is implicit.
X-UCE-Policy: No unsolicited commercial email is accepted at this site.  The sending of any UCE to this domain may result in the imposition of civil liability against the sender in accordance with Cal. Bus. & Prof. Code Section 17538.45, and all senders of UCE will be permanently blocked.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,
I'm seeing a problem with mounting CDs using a Toshiba XM-6401TA CDROM
drive attached to an Adaptec AHA1542CF controller (scsi1) on kernel 2.4.3
and 2.4.4.  The behavior seems to be fairly consistent as follows:

first mount and unmount works normally, no unusual events logged
second mount and unmount works normally, no unusual events logged
third mount locks up the machine.  looks like a kernel panic.

Any ideas?


-- 
 Linux Now!   ..........Because friends don't let friends use Microsoft.
 phil stracchino   --   the renaissance man   --   mystic zen biker geek
    Vr00m:  2000 Honda CBR929RR   --   Cage:  2000 Dodge Intrepid R/T
 Previous vr00mage:  1986 VF500F (sold), 1991 VFR750F3 (foully murdered)
