Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVLMJVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVLMJVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVLMJVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:21:54 -0500
Received: from ns2.suse.de ([195.135.220.15]:2237 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932604AbVLMJVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:21:53 -0500
Date: Tue, 13 Dec 2005 10:21:51 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       dhowells@redhat.com, torvalds@osdl.org, hch@infradead.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213092151.GR23384@wotan.suse.de>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213084926.GN23384@wotan.suse.de> <20051213090941.GA20490@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213090941.GA20490@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Or start using icecream (http://wiki.kde.org/icecream)
> 
> distcc is pretty good too. I have a minimal kernel build done in 19 
> seconds, a fuller build (1.5MB bzImage that boots on all my testboxes) 
> done in 45 seconds, using gcc 4.0.2.

icecream is better though - it reacts dynamically to your network
and it handles different installed compiler versions and cross compilation
nicely.

-Andi
