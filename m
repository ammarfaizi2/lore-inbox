Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVDBCHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVDBCHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 21:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVDBCHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 21:07:42 -0500
Received: from fmr23.intel.com ([143.183.121.15]:11917 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261652AbVDBCFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 21:05:17 -0500
Message-Id: <200504020205.j32256g05369@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Paul Jackson'" <pj@engr.sgi.com>
Cc: <mingo@elte.hu>, <nickpiggin@yahoo.com.au>, <torvalds@osdl.org>,
       <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Date: Fri, 1 Apr 2005 18:05:06 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU3JZddfPuIAJuBRoCbamUGzcTi4QAAQr0Q
In-Reply-To: <20050401174435.4117c940.pj@engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote on Friday, April 01, 2005 5:45 PM
> Kenneth wrote:
> > Paul, you definitely want to check this out on your large numa box.
>
> Interesting - thanks.  I can get a kernel patched and booted on a big
> box easily enough.  I don't know how to run an "industry db benchmark",
> and benchmarks aren't my forte.

To run this "industry db benchmark", assuming you have a 32-way numa box,
I recommend buying the following:

512 GB memory
1500 73 GB 15k-rpm fiber channel disks
50 hardware raid controllers, make sure you get the top of the line model
   (the one has 1GB memory in the controller).
25 fiber channel controllers
4  gigabit ethernet controllers.
12 rack frames

Then you will be off to go.  Oh, get several 220 volt power outlets too,
probably some refrigeration unit will go along with that.  Sorry, I
haven't mention the mid-tier and the client machines yet.

;-)


