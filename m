Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262949AbVGNXDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVGNXDQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVGNWSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:18:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:14552 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262566AbVGNWSH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:18:07 -0400
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce] linux kernel performance project launch at sourceforge.net
References: <200507142021.j6EKLPg04710@unix-os.sc.intel.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Jul 2005 00:18:03 +0200
In-Reply-To: <200507142021.j6EKLPg04710@unix-os.sc.intel.com.suse.lists.linux.kernel>
Message-ID: <p73y889kp5w.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:

> I'm pleased to announce that we have established a linux kernel
> performance project, hosted at sourceforge.net:
> 
> http://kernel-perf.sourceforge.net

That's very cool. Thanks a lot.

Would it be possible to add 2.4.30 numbers and perhaps one or two 
distro kernels (let's say RHEL3/4, SLES8/9) to the graphs 
as data points for comparison? These are all very tuned
kernels and would show where mainline is worse than them.

Also how did you run netperf? Locally or to some other machine? 
Perhaps that should be documented.

Some oprofile listings from a few of the test runs would be also nice.

-Andi
