Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVHMWV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVHMWV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 18:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVHMWVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 18:21:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932377AbVHMWVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 18:21:25 -0400
Date: Sat, 13 Aug 2005 15:21:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Henrik Brix Andersen <brix@gentoo.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Watchdog device node name unification
In-Reply-To: <1123970037.13656.16.camel@sponge.fungus>
Message-ID: <Pine.LNX.4.58.0508131520520.3553@g5.osdl.org>
References: <1123969015.13656.13.camel@sponge.fungus> <1123970037.13656.16.camel@sponge.fungus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Aug 2005, Henrik Brix Andersen wrote:
> 
> The last patch was accidentally against 2.6.12 - this one is against
> 2.6.13-rc6.

Doesn't seem to be serious enough to be worth it at this late stage in the 
2.6.13 game. Can you re-send after I do a release?

		Linus
