Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268220AbTBYUNN>; Tue, 25 Feb 2003 15:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268222AbTBYUNN>; Tue, 25 Feb 2003 15:13:13 -0500
Received: from [195.223.140.107] ([195.223.140.107]:57734 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268220AbTBYUNM>;
	Tue, 25 Feb 2003 15:13:12 -0500
Date: Tue, 25 Feb 2003 21:23:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sf.et,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030225202335.GU29467@dualathlon.random>
References: <96700000.1045871294@w-hlinder> <20030222192424.6ba7e859.akpm@digeo.com> <20030225171727.GN29467@dualathlon.random> <20030225174359.GA10411@holomorphy.com> <20030225175928.GP29467@dualathlon.random> <20030225185008.GF10396@holomorphy.com> <20030225191817.GT29467@dualathlon.random> <20030225201023.GG10396@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225201023.GG10396@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 12:10:23PM -0800, William Lee Irwin III wrote:
> I'd just bite the bullet and do the anonymous rework. Building
> pte_chains lazily raises the issue of needing to allocate in order to

note that there is no need of allocate to free.

Andrea
