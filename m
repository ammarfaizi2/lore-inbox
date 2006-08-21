Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWHUXhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWHUXhB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWHUXhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:37:01 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35721 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750714AbWHUXg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:36:58 -0400
Date: Tue, 22 Aug 2006 01:33:38 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andi Kleen <ak@suse.de>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
In-Reply-To: <20060822002728.c023bf85.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608220133020.6761@scrub.home>
References: <20060821212154.GO11651@stusta.de> <20060821232444.9a347714.ak@suse.de>
 <20060821214636.GP11651@stusta.de> <20060822000903.441acb64.ak@suse.de>
 <20060821222412.GS11651@stusta.de> <20060822002728.c023bf85.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 22 Aug 2006, Andi Kleen wrote:

> > It disables the automatic usage of builtins which is OK.
> 
> No, it's not ok -- it is the problem. We want to use the builtins.

I agree and for m68k I have a patch to fix this properly.

bye, Roman
