Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265970AbRF1OWr>; Thu, 28 Jun 2001 10:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265969AbRF1OWi>; Thu, 28 Jun 2001 10:22:38 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:3776 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265959AbRF1OWU>;
	Thu, 28 Jun 2001 10:22:20 -0400
Subject: Announcing Journaled File System (JFS)  release 1.0.0 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF2156091A.838536E6-ON85256A79.004E872E@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Thu, 28 Jun 2001 09:22:13 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 06/28/2001 10:22:14 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

June 28, 2001:

IBM is pleased to announce the v 1.0.0 release of the open source
Journaled File System (JFS), a high-performance, and scalable file
system for Linux.

http://oss.software.ibm.com/jfs

JFS is widely recognized as an industry-leading high-performance file
system, providing rapid recovery from a system power outage or crash
and the ability to support extremely large disk configurations. The
open source JFS is based on proven journaled file system technology
that is available in a variety of operating systems such as AIX and
OS/2.

JFS was open sourced under the GNU General Public License with release
v 0.0.1 on February 2. 2000 and has matured with help and support of the
open source community and its "Enterprise ready" release today is due
to joint work between the JFS team and the community. Following the
development style of "Release Early, Release Often" the JFS open source
project has seen 37 interim releases as part of the process.

The open source JFS for Linux v 1.0.0 is released for the Linux 2.4.x
kernel and offers the following advanced features:

* Fast recovery after a system crash or power outage

* Journaling for file system integrity

* Journaling of meta-data only

* Extent-based allocation

* Excellent overall performance

* 64 bit file system

* Built to scale. In memory and on-disk data structures are designed to
  scale beyond practical limit

* Designed to operate on SMP hardware and also a great file system for
  your workstation

* Completely free of prerequisite kernel changes (easy integration path
  into the kernel source tree)

* Detailed Howto for creating a system with JFS as the /boot and /root
  file system using lilo

* Complete set of file system utilities

* On-disk compatibility with OS/2 JFS file systems

The JFS Team (Barry Arndt, Steve Best, Dave Kleikamp)





