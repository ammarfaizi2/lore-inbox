Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbULGKvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbULGKvs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 05:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbULGKvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 05:51:48 -0500
Received: from gprs214-221.eurotel.cz ([160.218.214.221]:53635 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261769AbULGKvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 05:51:44 -0500
Date: Tue, 7 Dec 2004 11:51:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, clameter@sgi.com,
       hugh@veritas.com, benh@kernel.crashing.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance tests
Message-ID: <20041207105126.GA1605@elf.ucw.cz>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org> <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041201223441.3820fbc0.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Or start alternating between stable and flakey releases, so 2.6.11 will be
> a feature release with a 2-month development period and 2.6.12 will be a
> bugfix-only release, with perhaps a 2-week development period, so people
> know that the even-numbered releases are better stabilised.

If you expect "feature 2.6.11", you might as well call it 2.7.0, 
followed by 2.8.0.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
