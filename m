Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbSLQH1N>; Tue, 17 Dec 2002 02:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264806AbSLQH1N>; Tue, 17 Dec 2002 02:27:13 -0500
Received: from [203.199.93.15] ([203.199.93.15]:44044 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S264779AbSLQH1M>; Tue, 17 Dec 2002 02:27:12 -0500
From: "arun4linux" <arun4linux@indiatimes.com>
Message-Id: <200212170729.MAA27138@WS0005.indiatimes.com>
To: <linux-kernel@vger.kernel.org>
Reply-To: "arun4linux" <arun4linux@indiatimes.com>
Subject: Data-loss bug stings Linux
Date: Tue, 17 Dec 2002 13:08:24 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got an e-mail like this.
Just want to get clarified as I'm using RedHat 8.0 (kernel 2.4.18-14)
----------
Programmers have found a bug in newer versions of the Linux operating system that, under unusual circumstances, could cause systems to drop data

The data-loss bug afflicts the newest 2.4.20 version of the heart, or kernel, of Linux. The new kernel was released Nov. 28 in Linux companies' updates but is not yet a part of their packaged products. 

Although the bug was reported while the 2.4.20 version was still in testing, it wasn't fixed until early Friday morning, two weeks after final release. 

 
To counteract such tracking problems in the future, Linux programmers have begun using more formal bug-tracking tools. Bugs and security problems are big issues today because of the ever-wider use of computer networks and the increasing importance of corporate data. Microsoft, Sun Microsystems, Linux fans and others all are keenly aware of the publicity benefits of crash-proof code, and the perils of problems.

Data-loss problems are dire--companies devote much of their computing budgets to keeping their information from vanishing into the ether. 

However, the risks of the recent Linux data-loss bug are reduced because it only appears in a particular circumstance: First, an administrator has to select an unusual mode for Linux's ext3 file system software, which controls how data is stored on hard drives; then the administrator must disconnect the file system where the data is saved. In that case, all data that should have been saved on the hard drive in the previous 30 seconds could be lost. 

The data-loss problem is "not very severe," said programmer Andrew Morton in an e-mail interview. It was Morton who pointed out Sunday that the bug hadn't been fixed and who posted a patch Friday. 

Morton added that the bug is contingent on using ext3 in "a specialized mode, which in practice is rather slow. It doesn't offer any realistic advantages over the default...mode, and nobody uses it much. This is why the bug lay dormant for three months." 


Red Hat, the top Linux seller, said its customers are only affected by the bug if they downloaded Red Hat updates that incorporate version 2.4.18-17 or later of the Linux kernel. The company made those updates available for versions 7.1, 7.2, 7.3 and 8.0 of Red Hat Linux. Its Advanced Server product isn't affected.

The most recent updates from No. 2 Linux seller SuSE also are affected, the SuSE said. However, SuSE by default uses a different file system, ReiserFS, that isn't affected. 

The data-loss problem was originally found by programmer Nick Piggin, who said it may have affected all 2.4.19 kernels in addition to version 2.4.20. Morton, however, believes Piggin's first bug report in July for preliminary versions of 2.4.19 is likely a different--but related--bug that's harder to trigger. 

Buttoning up Tux patches
Though this bug slipped through the cracks for a time, Linux programmers are working to create a less freewheeling process for tracking and fixing problems in their code. The Linux community, a self-directed group of programmers who collectively develop the Unix clone, doesn't have a suit-and-tie dress code, but it is becoming more formal. 

For example, in November the Open Source Development Lab--a collaboration of IBM, Intel, Hewlett-Packard and others working to improve Linux for high-end systems--began an effort to track bugs more carefully. It announced the Kernel Bug Tracker in a posting to the Linux kernel mailing list, and several programmers signed up to supervise various parts of the project. 

Red Hat already has its own bug-tracking site; it and the new OSDL site both use the open-source Bugzilla bug-tracking software. 

In addition, Linux programmers have begun to adopt the BitKeeper collaborative programming tool for managing their code. These more formal processes please companies such as IBM that have bet heavily on Linux. 

In a related development, the open-source world has become more tightly tied to the existing bug-tracking industry, fitting into established security mechanisms such as Mitre's Common Vulnerabilities and Exposures database. Conversely, security organizations are learning how to accommodate open-source groups.
------

Warm Regards
Arun


Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy the best in Movies at http://www.videos.indiatimes.com

Now bid just 7 Days in Advance and get Huge Discounts on Indian Airlines Flights. So log on to http://indianairlines.indiatimes.com and Bid Now!

