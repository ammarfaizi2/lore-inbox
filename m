Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSCSWrE>; Tue, 19 Mar 2002 17:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293151AbSCSWqo>; Tue, 19 Mar 2002 17:46:44 -0500
Received: from pool-151-204-76-61.delv.east.verizon.net ([151.204.76.61]:24069
	"EHLO trianna.2y.net") by vger.kernel.org with ESMTP
	id <S293135AbSCSWqi>; Tue, 19 Mar 2002 17:46:38 -0500
Date: Tue, 19 Mar 2002 17:46:40 -0500
From: Malcolm Mallardi <magamo@ranka.2y.net>
To: linux-kernel@vger.kernel.org
Subject: EFS bug? (2.4.19-pre2)
Message-ID: <20020319174640.A9888@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hey folks, in 2.4.19-pre2, and any kernel I've tried
previously, when I attempt to mount an EFS filesystem off of my
IDE-SCSI controlled CD-ROM drive mount will segfault.  I have also had
reports of the same happening with actual SCSI hardware CD-ROMS. I'm
assuming that this is either an efs bug, or a SCSI/CDROM bug, because
mounting the same CD on the computer's straight IDE CD Drive works just
fine.	

--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net:3000/~magamo/index.htm
