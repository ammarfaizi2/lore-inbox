Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315797AbSEJERo>; Fri, 10 May 2002 00:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315798AbSEJERn>; Fri, 10 May 2002 00:17:43 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:25795 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S315797AbSEJERn>; Fri, 10 May 2002 00:17:43 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Date: Fri, 10 May 2002 14:17:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15579.18888.836198.925634@notabene.cse.unsw.edu.au>
Subject: ANNOUNCE: mdadm 1.0.0 - A tool for managing Soft RAID under Linux
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I am pleased to announce the availability of 
   mdadm version 1.0.0
It is available at
   http://www.cse.unsw.edu.au/~neilb/source/mdadm/

as both a source tar-ball, as an SRPM, and as an RPM for i386.

mdadm is a tool for creating, managing and monitoring
device arrays using the "md" driver in Linux, also
known as Software RAID arrays.

mdadm incorporates much of the functionality of raidtools, though with
a very different interface, and also provides extra functionality
including:
   - monitoring array and alerting admin staff of issues
   - moving spares between arrays as needed
   - assembling arrays based on superblock content
   - displaying details of arrays and of superblocks

The release of version 1 is intended to suggest that mdadm is
   - feature-complete
   - reasonably bug-free
   - reasonably well documented.

I hope not to make another release until md driver enhancements
necessitate it, but we will have to wait and see....

Note: mdadm was previously known as 'mdctl'.  It is the same tool,
just a different name.

Development of mdadm is sponsored by CSE@UNSW: 
  The School of Computer Science and Engineering
at
  The University of New South Wales

NeilBrown  10may2002
