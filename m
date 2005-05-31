Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVEaSrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVEaSrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 14:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVEaSrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 14:47:12 -0400
Received: from web32411.mail.mud.yahoo.com ([68.142.207.204]:6241 "HELO
	web32411.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261178AbVEaSrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 14:47:05 -0400
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=lghr0ktWukld0L49knxBZL5HgsBUsfRMoPlOcHGnYLbf5g0JbttbuJUVPIRPo49Lh1X5olHVYcPdimEj0CZnPI/4RJKVtLhDC/NoAUxNSIt4smdaiIDAxMncehS1JF84MVl4iRTRV9ejTasioMWVqGRWqieHKj1CuLRop4DLV3E=  ;
Message-ID: <20050531184704.44932.qmail@web32411.mail.mud.yahoo.com>
Date: Tue, 31 May 2005 11:47:04 -0700 (PDT)
From: Anil kumar <anils_r@yahoo.com>
Subject: suse 9.3pro x86_64 kernel source rpm fixdep script error
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I downloaded SuSE 9.3pro x86_64 kernel-source rpm
from:
http://mirror.tv2.dk/pub/linux/suse/people/mantel/kotd/9.3-x86_64/SL93_BRANCH/

After extracting the rpm, the scripts under:
/usr/src/linux-2.6.11.4-SL93_BRANCH_20050525084504-obj/x86_64/default/scripts/basic

The script "fixdep" reports error as:
bash: ./fixdep: cannot execute binary file

#ll fixdep
-rwxr-xr-x 2 root root 9120 May 31 09:25 fixdep

Looks like I have right execute permissions. Is it
something I am missing/overlooked? Or the script is
bad?

FYI, I did rpm2cpio to extract it.

Thanks for help in advance.

with regards,
  Anil




		
__________________________________ 
Yahoo! Mail 
Stay connected, organized, and protected. Take the tour: 
http://tour.mail.yahoo.com/mailtour.html 

