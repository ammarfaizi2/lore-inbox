Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbVKBFxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbVKBFxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbVKBFxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:53:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9119 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751520AbVKBFxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:53:09 -0500
Date: Tue, 1 Nov 2005 21:53:04 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@linux.ie>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [git tree] drm tree for 2.6.15
In-Reply-To: <Pine.LNX.4.58.0511010934060.13867@skynet>
Message-ID: <Pine.LNX.4.64.0511012150190.27915@g5.osdl.org>
References: <Pine.LNX.4.58.0511010934060.13867@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Nov 2005, Dave Airlie wrote:
>
> 	Can you pull the drm-linus branch from
> 
> 	www.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git
> 
> It is mainly a lindenting of the DRM along with an updated radeon DRM to
> support PCI Express R300 cards, along with some sparse fixes..

I got a few merge clashes with the previous fix from Ivan Kokshaysky, 
which I fixed up by hand.

I think I did them right, but you should check.

		Linus
