Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbUCYWXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUCYWXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:23:55 -0500
Received: from gprs214-160.eurotel.cz ([160.218.214.160]:15489 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263633AbUCYWXx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:23:53 -0500
Date: Thu, 25 Mar 2004 23:23:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rik van Riel <riel@redhat.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] RSS limit enforcement for 2.6
Message-ID: <20040325222340.GD2179@elf.ucw.cz>
References: <20040318220432.GB1505@openzaurus.ucw.cz> <Pine.LNX.4.44.0403250944250.11915-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403250944250.11915-100000@chimarrao.boston.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > When running lingvistics computation, machine got completely
> > unusable due to bad memory pressure. nice -n 19 was
> > useless. Memory limit should help.
> 
> Is this with the new patch, with the old patch or
> without any RSS limiting patch ?

That was without any RSS limiting patch. I'm sorry, I have no time for
lingvistics just now.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
