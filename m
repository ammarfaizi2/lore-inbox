Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266003AbRF1P73>; Thu, 28 Jun 2001 11:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266000AbRF1P7T>; Thu, 28 Jun 2001 11:59:19 -0400
Received: from fit.edu ([163.118.5.1]:41113 "EHLO fit.edu")
	by vger.kernel.org with ESMTP id <S266003AbRF1P7K>;
	Thu, 28 Jun 2001 11:59:10 -0400
Message-ID: <3B3B5508.11FB04B6@fit.edu>
Date: Thu, 28 Jun 2001 12:02:16 -0400
From: Kervin Pierre <kpierre@fit.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Announcing Journaled File System (JFS)  release 1.0.0 available
In-Reply-To: <OF2156091A.838536E6-ON85256A79.004E872E@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Question.

Are there plans to include JFS and XFS in the kernel?  

Both those projects have been declared stable by their development
teams, and I'm guessing they can now be included as experimental, just
as reiser has been.

Just curious,
-Kervin


Steve Best wrote:
> 
> June 28, 2001:
> 
> IBM is pleased to announce the v 1.0.0 release of the open source
> Journaled File System (JFS), a high-performance, and scalable file
> system for Linux.
> 
> http://oss.software.ibm.com/jfs
> 
> JFS is widely recognized as an industry-leading high-performance file
> system, providing rapid recovery from a system power outage or crash
> and the ability to support extremely large disk configurations. The
> open source JFS is based on proven journaled file system technology
> that is available in a variety of operating systems such as AIX and
> OS/2.
> 
> JFS was open sourced under the GNU General Public License with release
> v 0.0.1 on February 2. 2000 and has matured with help and support of the
> open source community and its "Enterprise ready" release today is due
> to joint work between the JFS team and the community. Following the
> development style of "Release Early, Release Often" the JFS open source
> project has seen 37 interim releases as part of the process.
> 
> The open source JFS for Linux v 1.0.0 is released for the Linux 2.4.x
> kernel and offers the following advanced features:
> 
> * Fast recovery after a system crash or power outage
> 
> * Journaling for file system integrity
> 
> * Journaling of meta-data only
> 
> * Extent-based allocation
> 
> * Excellent overall performance
> 
> * 64 bit file system
> 
> * Built to scale. In memory and on-disk data structures are designed to
>   scale beyond practical limit
> 
> * Designed to operate on SMP hardware and also a great file system for
>   your workstation
> 
> * Completely free of prerequisite kernel changes (easy integration path
>   into the kernel source tree)
> 
> * Detailed Howto for creating a system with JFS as the /boot and /root
>   file system using lilo
> 
> * Complete set of file system utilities
> 
> * On-disk compatibility with OS/2 JFS file systems
> 
> The JFS Team (Barry Arndt, Steve Best, Dave Kleikamp)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
