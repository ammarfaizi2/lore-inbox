Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289792AbSAWLK3>; Wed, 23 Jan 2002 06:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289790AbSAWLKS>; Wed, 23 Jan 2002 06:10:18 -0500
Received: from [202.54.26.202] ([202.54.26.202]:5513 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S289789AbSAWLKK>;
	Wed, 23 Jan 2002 06:10:10 -0500
X-Lotus-FromDomain: HSS
From: gspujar@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256B4A.003D4CD1.00@sandesh.hss.hns.com>
Date: Wed, 23 Jan 2002 16:43:18 +0530
Subject: file system unmount
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
I am using softdog in my application. One of the problems I am facing is,
when the system comes up after the reboot forced by softdog, file system gets
corrupted and fsck has to check. Some times fsck fails to force check the file
system and
the system enters in to run level 1, leading to manual intervention.

Any idea how to unmount the file system before the system is rebooted by
softdog, so
that system always comes up properly without manual intervention.

Thanks
-Girish



"DISCLAIMER: This message is proprietary to Hughes Software Systems Limited
(HSS) and is intended solely for the use of the individual  to whom it is
addressed. It may contain  privileged or confidential information  and should
not be circulated or used for any purpose other than for what it is intended. If
you have received this message in error, please notify the originator
immediately. If you are not the intended recipient, you are notified that you
are strictly prohibited from using, copying, altering, or disclosing the
contents of this message. HSS accepts no responsibility for loss or damage
arising from the use of the information transmitted by this email including
damage from virus."





