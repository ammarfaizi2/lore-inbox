Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRDTWJZ>; Fri, 20 Apr 2001 18:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbRDTWJO>; Fri, 20 Apr 2001 18:09:14 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:56336 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S132053AbRDTWJL>; Fri, 20 Apr 2001 18:09:11 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256A34.0079A841.00@smtpnotes.altec.com>
Date: Fri, 20 Apr 2001 17:08:53 -0500
Subject: Current status of NTFS support
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Where does write support for NTFS stand at the moment?  I noticed that it's
still marked "Dangerous" in the kernel configuration.  This is important to me
because it looks like I'll have to start using it next week.  My office laptop
is going to be "upgraded" from Windows 98 to 2000.  Of course, I hardly ever
boot into Windows any more since installing a Linux partition last year.  But
our corporate email standard forces me to use Lotus Notes, which I run under
Wine.   The Notes executables and databases are installed on my Windows
partition.  The upgrade, though, will involve wiping the hard drive, allocating
the whole drive to a single NTFS partition, and reinstalling Notes after
installing Windows 2000 .  That means bye-bye FAT32 partition and hello NTFS.  I
can't mount it read-only because I'll still have to update my Notes databases
from Linux.  So how risky is this?

Also, I'll have to recreate my Linux partitions after the upgrade.  Does anyone
know if FIPS can split a partition safely that was created under Windows
2000/NT?  It worked fine for Windows 98, but I'm a little worried about what
might happen if I try to use it on an NTFS partition.

I'd appreciate any advice or help anyone can give me.  There's just no way I can
stand going back to using anything but Linux for my daily work.

Wayne


