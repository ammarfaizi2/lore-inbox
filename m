Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288611AbSAXQFd>; Thu, 24 Jan 2002 11:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288422AbSAXQFY>; Thu, 24 Jan 2002 11:05:24 -0500
Received: from p3EE02ABD.dip.t-dialin.net ([62.224.42.189]:2052 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S288624AbSAXQFK>;
	Thu, 24 Jan 2002 11:05:10 -0500
Date: Thu, 24 Jan 2002 17:01:28 +0100
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: linux-kernel@vger.kernel.org
Subject: *** ANNOUNCEMENT *** LVM 1.0.2 available at www.sistina.com
Message-ID: <20020124170128.A9435@sistina.com>
Reply-To: mauelshagen@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


*** ANNOUNCEMENT *** LVM 1.0.2 available at www.sistina.com

Hi all,

LVM 1.0.2 supports both version 1 and 2 of the metadata.

There's *no* need to run any metadata update tools.

A tarball is available now at

   <http://www.sistina.com/>

for download (Follow the "LVM 1.0" link).


This release contains minor changes to LVM 1.0.1 including:

o Linux 2.4.17 support
o sparc 64 fixes (tests needed!)
o persistent LV device minors to support client recovery after
  a NFS server reboot/failover
o ataraid device support
o support loop devices (they do not show up in /proc/partitions) 


See the CHANGELOG file contained in the tarball for further information.

Feed back LVM related information to <linux-lvm@sistina.com>.

Thanks a lot for your support of LVM.

