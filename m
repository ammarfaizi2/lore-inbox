Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbTCBXNJ>; Sun, 2 Mar 2003 18:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbTCBXNI>; Sun, 2 Mar 2003 18:13:08 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:39392 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S262418AbTCBXNG>; Sun, 2 Mar 2003 18:13:06 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 3 Mar 2003 10:23:05 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15970.37465.869711.682093@notabene.cse.unsw.edu.au>
Subject: ANNOUNCE: mdadm 1.1.0 - A tool for managing Soft RAID under Linux
X-Mailer: VM 7.08 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I am pleased to announce the availability of 
   mdadm version 1.1.0
It is available at
   http://www.cse.unsw.edu.au/~neilb/source/mdadm/
and
   http://www.{countrycode}.kernel.org/pub/utils/raid/mdadm/

as a source tar-ball and (at the first site) as an SRPM, and as an RPM for i386.

mdadm is a tool for creating, managing and monitoring
device arrays using the "md" driver in Linux, also
known as Software RAID arrays.

Release 1.1.0 contains a number of spell corrections, and bug fixes.
It has improved support for MULTIPATH arrays.
It has some new features including:
  --daemonise   	for use with --monitor
  --config=partitions   to find devices by examining /proc/partitions
  --update=super-minor  to change the recorded minor-number for an array

Much of the improvements are due to user feed-back.  Thanks are due to all who 
gave suggestions and reported problems.

I expect the next major release to be 2.0.0 which will include support for 
a new super-block format soon to be supported by 2.5 series kernels.


Development of mdadm is sponsored by CSE@UNSW: 
  The School of Computer Science and Engineering
at
  The University of New South Wales

NeilBrown  03/03/03
   The third day 
of the third month
of the third year
of the third millenium

