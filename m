Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267896AbTBRQAs>; Tue, 18 Feb 2003 11:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267897AbTBRQAr>; Tue, 18 Feb 2003 11:00:47 -0500
Received: from franka.aracnet.com ([216.99.193.44]:30882 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267896AbTBRQAq>; Tue, 18 Feb 2003 11:00:46 -0500
Date: Tue, 18 Feb 2003 08:10:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 374] New: problems with /proc/ide/via 
Message-ID: <2470000.1045584640@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=374

           Summary: problems with /proc/ide/via
    Kernel Version: 2.5.62
            Status: NEW
          Severity: normal
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: janekh@cvotech.com


Distribution: redhat 7.3
Hardware Environment: ASUS A7V266-C with athlon 1700+ XP, 512 MB ram
Software Environment: gcc 2.96 20000731
Problem Description:

the /prod/ide/via is not complete. it ends like :

Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UD

wheres on 2.4.20 it works fine.


