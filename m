Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUEWJA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUEWJA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUEWJA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:00:59 -0400
Received: from cantor.suse.de ([195.135.220.2]:10931 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262422AbUEWJA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:00:57 -0400
To: Roland McGrath <roland@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bogus sigaltstack calls by rt_sigreturn
References: <200405230201.i4N21x4J022595@magilla.sf.frob.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: HOORAY, Ronald!!  Now YOU can marry LINDA RONSTADT too!!
Date: Sun, 23 May 2004 11:00:56 +0200
In-Reply-To: <200405230201.i4N21x4J022595@magilla.sf.frob.com> (Roland
 McGrath's message of "Sat, 22 May 2004 19:01:59 -0700")
Message-ID: <jelljjqzzr.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> writes:

> The patch below fixes only the i386 and x86_64 versions.  The x86_64
> patches I have not actually tested.  I think each and every arch (except
> ppc and ppc64) need to make the corresponding fixes as well.

m68k seems to be safe as well.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
