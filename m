Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVDJWr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVDJWr4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 18:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVDJWr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 18:47:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:63629 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261625AbVDJWry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 18:47:54 -0400
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL
	accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Moritz Muehlenhoff <jmm@inutil.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <E1DKZJn-0001dN-KQ@localhost.localdomain>
References: <1110519743.5810.13.camel@gaston>
	 <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	 <1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	 <1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	 <21d7e9970504071422349426eb@mail.gmail.com>
	 <1112914795.9568.320.camel@gaston> <jemzsa6sxg.fsf@sykes.suse.de>
	 <1112923186.9567.349.camel@gaston> <jezmw9ug7j.fsf@sykes.suse.de>
	 <1113005006.9568.402.camel@gaston> <jey8brj4tx.fsf@sykes.suse.de>
	 <1113089591.9518.440.camel@gaston>
	 <E1DKZJn-0001dN-KQ@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Apr 2005 08:45:29 +1000
Message-Id: <1113173129.9568.501.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But it's not specific to X11; I've applied the patch you posted and the
> same symptoms occur for pure tty switching as well, the delay has decreased
> a bit (it's hard to measure, but around a second), but it's still rather
> annoying to work with.
> 
> Is it distinguishable which M6 models are buggy? I'm using my X31 for about
> a year now and have probably made some tens of thousands of switches without
> lockups, so presumably not all models cause lockups.

ATI hasn't been very precise about that unfortunately...

Ben.


