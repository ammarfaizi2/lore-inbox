Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWC1VoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWC1VoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWC1VoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:44:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13962 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932248AbWC1Vn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:43:59 -0500
Date: Wed, 29 Mar 2006 07:43:33 +1000
From: Nathan Scott <nathans@sgi.com>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: kernel BUG at fs/direct-io.c:916!
Message-ID: <20060329074333.E871924@wobbly.melbourne.sgi.com>
References: <20060326230206.06C1EE083AAB@knarzkiste.dyndns.org> <20060326180440.GA4776@charite.de> <20060326184644.GC4776@charite.de> <20060327080811.D753448@wobbly.melbourne.sgi.com> <20060326230358.GG4776@charite.de> <20060327060436.GC2481@frodo> <20060327110342.GX21946@charite.de> <20060328050135.GA2177@frodo> <20060328112859.GA3851@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060328112859.GA3851@charite.de>; from Ralf.Hildebrandt@charite.de on Tue, Mar 28, 2006 at 01:28:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 01:28:59PM +0200, Ralf Hildebrandt wrote:
> * Nathan Scott <nathans@sgi.com>:
> 
> > OK, I think I see whats gone wrong here now.  Ralf, could you try
> > the patch below and check that it fixes your test case?
> 
> The patch is against what? -git12? 2.6.16?

Should apply cleanly to the current git tree (did yesterday, anyway).

cheers.

-- 
Nathan
