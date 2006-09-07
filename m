Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWIGLke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWIGLke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWIGLke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:40:34 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16066 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750896AbWIGLkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:40:33 -0400
Date: Thu, 7 Sep 2006 13:40:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
In-Reply-To: <20060907102740.GH25473@stusta.de>
Message-ID: <Pine.LNX.4.64.0609071332500.6761@scrub.home>
References: <20060830175727.GI18276@stusta.de> <200608302013.58122.ak@suse.de>
 <20060830183905.GB31594@flint.arm.linux.org.uk> <20060906223748.GC12157@stusta.de>
 <20060907063049.GA15029@flint.arm.linux.org.uk> <20060907102740.GH25473@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Sep 2006, Adrian Bunk wrote:

> And I'm getting bashed for sendind a patch to revert it "only" to 
> linux-kernel...

No, you get "bashed" for pushing a patch that only hides problems instead 
of fixing them and that only creates new problems.

> (who has just deleted all his cross compilers for getting rid of all 
>  these troubles)

Your help is certainly appreciated, but you have to work a bit more with 
the people who actually use these platforms.

bye, Roman
