Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262993AbVAFTn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbVAFTn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 14:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbVAFTjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 14:39:14 -0500
Received: from zeus.kernel.org ([204.152.189.113]:32426 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261166AbVAFTfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 14:35:55 -0500
Date: Thu, 6 Jan 2005 20:35:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Lang <dlang@digitalinsight.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Rik van Riel <riel@redhat.com>,
       Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050106193510.GL3096@stusta.de>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com> <20050103153438.GF2980@stusta.de> <1104767943.4192.17.camel@laptopd505.fenrus.org> <20050104174712.GI3097@stusta.de> <Pine.LNX.4.60.0501041215500.9517@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0501041215500.9517@dlang.diginsite.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 12:18:26PM -0800, David Lang wrote:

> Sorry, I've been useing kernel.org kernels since the 2.0 days and even 
> within a stable series I always do a full set of tests before upgrading. 
> every single stable series has had 'paper bag' releases, and every single 
> one has had fixes to drivers that have ended up breaking those drivers.
> 
> the only way to know if a new kernel will work on your hardware is to try 
> it. It doesn't matter if the upgrade is from 2.4.24 to 2.4.25 or 2.6.9 to 
> 2.6.10 or even 2.4.24 to 2.6.10
> 
> anyone who assumes that just becouse the kernel is in the stable series 
> they can blindly upgrade their production systems is just dreaming.

I was not thinking about a "blindly upgrade".

But the question is if you compile and test a kernel, is it every 
unlikely or relatively common to observe new problems?

> David Lang

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

