Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262609AbUKXKky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbUKXKky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUKXKky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:40:54 -0500
Received: from ns.suse.de ([195.135.220.2]:43979 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262609AbUKXKkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:40:41 -0500
Date: Wed, 24 Nov 2004 11:40:37 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@lst.de>, ak@suse.de,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] x86_64 hardirq.h: no need to #ifdef CONFIG_X86
Message-ID: <20041124104037.GB10495@wotan.suse.de>
References: <20041124001941.GF2927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124001941.GF2927@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 01:19:42AM +0100, Adrian Bunk wrote:
> 
> I can't see any reason for the #ifdef CONFIG_X86 introduced to the 
> x86_64 hardirq.h as part of the generic irq subsystem changes.

Looks good thanks. I added it to my patchkit.

-Andi
