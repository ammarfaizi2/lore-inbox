Return-Path: <linux-kernel-owner+w=401wt.eu-S1161071AbXALKd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbXALKd0 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 05:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161068AbXALKdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 05:33:25 -0500
Received: from cantor2.suse.de ([195.135.220.15]:53402 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161060AbXALKdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 05:33:24 -0500
From: Andreas Schwab <schwab@suse.de>
To: Horms <horms@verge.net.au>
Cc: "Zou, Nanhai" <nanhai.zou@intel.com>, Vivek Goyal <vgoyal@in.ibm.com>,
       Mohan Kumar M <mohan@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       fastboot@lists.osdl.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] Kdump documentation update for 2.6.20: ia64 portion
References: <20070112060724.GC17379@verge.net.au>
	<10EA09EFD8728347A513008B6B0DA77A086BAA@pdsmsx411.ccr.corp.intel.com>
	<20070112090043.GA27340@verge.net.au>
X-Yow: Now I need a suntan, a tennis lesson, Annette Funicello and two dozen
 Day-Glo orange paper jumpsuits!!
Date: Fri, 12 Jan 2007 11:33:22 +0100
In-Reply-To: <20070112090043.GA27340@verge.net.au> (horms@verge.net.au's
	message of "Fri, 12 Jan 2007 18:00:44 +0900")
Message-ID: <je1wm0h6vh.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms <horms@verge.net.au> writes:

> +  If the start address is specified, not that the start address of the
                                        note
> +  kernel will be alligned to 64Mb, so any if the start address is not then
                    aligned              XXX
> +  any space below the alignment point will be wasted.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
