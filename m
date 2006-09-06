Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWIFXls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWIFXls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWIFXls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:41:48 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8893 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751759AbWIFXlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:41:47 -0400
Date: Thu, 7 Sep 2006 01:38:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
In-Reply-To: <20060906223748.GC12157@stusta.de>
Message-ID: <Pine.LNX.4.64.0609070115270.6761@scrub.home>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de>
 <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Sep 2006, Adrian Bunk wrote:

> We are talking about reverting the patch that removed -ffreestanding, 
> and that broke at least two architectures although it wrongly claimed 
> it would have been a safe patch.

Your patch is nevertheless the wrong fix for one of these archs.

bye, Roman
