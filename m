Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWGKWTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWGKWTi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWGKWTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:19:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2568 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932200AbWGKWTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:19:37 -0400
Date: Wed, 12 Jul 2006 00:19:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
Message-ID: <20060711221936.GD13938@stusta.de>
References: <20060711160639.GY13938@stusta.de> <20060711190544.GB1240@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711190544.GB1240@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 08:05:44PM +0100, Russell King wrote:
> On Tue, Jul 11, 2006 at 06:06:39PM +0200, Adrian Bunk wrote:
> > My plan is to create a git tree where I'll work on this that will be 
> > included in -mm.
> > 
> > Is this OK for everyone?
> 
> Sure, provided it's also tested on non-x86 architectures as well.
>...

Sure.

There might still be compile errors in some configurations, but I'll 
test this stuff on several architectures.

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

