Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136628AbREAPGR>; Tue, 1 May 2001 11:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136629AbREAPGI>; Tue, 1 May 2001 11:06:08 -0400
Received: from nic-25-c96-156.mn.mediaone.net ([24.25.96.156]:39179 "EHLO
	lupo.thebarn.com") by vger.kernel.org with ESMTP id <S136620AbREAPGC>;
	Tue, 1 May 2001 11:06:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15086.53450.320884.346281@lupo.thebarn.com>
Date: Tue, 1 May 2001 10:05:46 -0500 (CDT)
From: xfs-masters@oss.sgi.com
Subject: Announce: XFS Release 1.0 for Linux
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tuesday May 1 2001:
SGI is pleased to announce the 1.0 release of XFS, high-performance
journaled file system for Linux. 

http://oss.sgi.com/projects/xfs/

XFS is widely recognized as the industry-leading high-performance file system,
providing rapid recovery from system crashes and the ability to support
extremely large disk farms. XFS is the first journaled file system for Linux
available today that has a proven track record in production environments
since December 1994. 

XFS Linux 1.0 is released for the Linux 2.4 kernel and offers the following
advanced features:

        * Fast recovery after a system crash or power failure, NO fsck!
        * Journaling for guaranteed file system integrity 
        * Direct I/O 
        * Space preallocation 
        * Transactionally recorded quotas 
        * Access control lists and Extended attributes 
        * Infrastructure for XDSM support (DMAPI) 
        * Excellent overall performance 
        * Excellent scalability (64 bit file system) 
        * On-disk compatibility with IRIX XFS file systems

A complete toolset including: 

        * dump/restore support including all XFS file system features such as ACLs and quotas 
        * Repair utility, file system editor, and growing the file system 
        * ACL editing utility 
        * Extended attribute editing utility

Excellent integration with other Linux subsystems: 
        * NFS version 2 and 3 server support 
        * Root file system and lilo support 
        * Software raid integration with md and lvm packages 
        * Mount by label and mount by uuid 


The SGI XFS team is also providing a modified Red Hat Linux anaconda based installer.
The installer handles all the details of setting up a Red Hat Linux 7.1 system running
entirely on XFS, or a combination of XFS and ext2 file systems.


Sincerely 
The SGI XFS Team.










