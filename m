Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbVGNW1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVGNW1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVGNWZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:25:15 -0400
Received: from fmr24.intel.com ([143.183.121.16]:18923 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262822AbVGNWYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:24:49 -0400
Message-Id: <200507142224.j6EMOjg06251@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [announce] linux kernel performance project launch at sourceforge.net
Date: Thu, 14 Jul 2005 15:24:45 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWIweuM0QQ0upfhTgCH2+XOVrpxowAACOuw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <p73y889kp5w.fsf@bragg.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ak@suse.de wrote on Thursday, July 14, 2005 3:18 PM
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:
> > I'm pleased to announce that we have established a linux kernel
> > performance project, hosted at sourceforge.net:
> > 
> > http://kernel-perf.sourceforge.net
> 
> That's very cool. Thanks a lot.

Thank you.


> Would it be possible to add 2.4.30 numbers and perhaps one or two 
> distro kernels (let's say RHEL3/4, SLES8/9) to the graphs 
> as data points for comparison? These are all very tuned
> kernels and would show where mainline is worse than them.

We did have a distro kernel in the graph originally and later decided
to go with pure mainline kernels for consistency.  We will see what we
can do to add them in the future.


> Also how did you run netperf? Locally or to some other machine? 
> Perhaps that should be documented.

Yes, that was netperf, running locally.  Thanks for the suggestion, I
will document that appropriately.


> Some oprofile listings from a few of the test runs would be also nice.

That is in the works.  We will upload profile data.  I'm having problem
with oprofile on some versions of kernel and that is being investigated
right now.

- Ken

