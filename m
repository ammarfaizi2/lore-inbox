Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbVDAWwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbVDAWwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbVDAWwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 17:52:00 -0500
Received: from fmr24.intel.com ([143.183.121.16]:3994 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262945AbVDAWvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 17:51:38 -0500
Message-Id: <200504012251.j31MpUg03810@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Industry db benchmark result on recent 2.6 kernels
Date: Fri, 1 Apr 2005 14:51:30 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU0uyq9M+SRbZwMT8KjJkO2VfZEaACUFhEw
In-Reply-To: <Pine.LNX.4.58.0503291546180.6036@ppc970.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote on Tuesday, March 29, 2005 4:00 PM
> Also, it would be absolutely wonderful to see a finer granularity (which
> would likely also answer the stability question of the numbers). If you
> can do this with the daily snapshots, that would be great. If it's not
> easily automatable, or if a run takes a long time, maybe every other or
> every third day would be possible?
>
> Doing just release kernels means that there will be a two-month lag
> between telling developers that something pissed up performance. Doing it
> every day (or at least a couple of times a week) will be much more
> interesting.

Indeed, we agree that regular disciplined performance testing is important
and we (as Intel) will take on the challenge to support the Linux community.
I just got an approval to start this project.  We will report more detail
on how/where to publish the performance number, etc.

- Ken


