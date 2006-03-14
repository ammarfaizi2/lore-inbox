Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWCNQGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWCNQGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWCNQGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:06:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750847AbWCNQGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:06:30 -0500
Date: Tue, 14 Mar 2006 08:06:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Andrew Clayton <andrew@rootshell.co.uk>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-git[12] spontaneous reboots on x86_64
In-Reply-To: <Pine.LNX.4.61.0603141523340.4309@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0603140805380.3618@g5.osdl.org>
References: <1142337319.4412.2.camel@zeus.pccl.info>
 <Pine.LNX.4.61.0603141523340.4309@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Mar 2006, Hugh Dickins wrote:
>
> Yep, that one's a turkey, definitely something for Linus to revert.

Reverted. Let's get wider testing before applying an alternate fix.

		Linus
