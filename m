Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280697AbRKLNQj>; Mon, 12 Nov 2001 08:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280691AbRKLNQ3>; Mon, 12 Nov 2001 08:16:29 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:16099 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S280697AbRKLNQW>; Mon, 12 Nov 2001 08:16:22 -0500
Importance: Normal
Subject: [Announce] Dynamic Probes v3.1 Released
To: dprobes@www-126.southbury.usf.ibm.com
Cc: ltc@linux.ibm.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFF59F0A58.DA825A0B-ON65256B02.004873A9@in.ibm.com>
From: "S Vamsikrishna" <vamsi_krishna@in.ibm.com>
Date: Mon, 12 Nov 2001 18:46:42 +0530
X-MIMETrack: Serialize by Router on d23m0067/23/M/IBM(Release 5.0.8 |June 18, 2001) at
 12/11/2001 06:46:50 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic Probes v 3.1 is released.

Dynamic Probes is a generic and pervasive debugging facility that will
operate under the most extreme software conditions such as debugging a
deep rooted operating system problem in a live environment.

The latest version of Dynamic Probes. It can be downloaded from:
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes/


Brief Changelog:

- fix kernel BUG in page_alloc.c that is triggered sometimes when the
  dprobes module (dp.o) is being removed
- fix to dr_alloc to make more than one watchpoint work
- fix to do_query (segfault on IA64)
- alloc only smp_num_cpu (not NR_CPUS) pages for aliasing
- update README to include module installation instructions
- add Configure.Help entries
- version/date updates to man pages

* If you are using v3.0 of DProbes, we recommend you to upgrade to this
version.

Regards.. Vamsi.

Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi_krishna@in.ibm.com

