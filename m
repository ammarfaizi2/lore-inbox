Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUKSMMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUKSMMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUKSMKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:10:05 -0500
Received: from ns.suse.de ([195.135.220.2]:44507 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261379AbUKSMJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:09:29 -0500
Date: Fri, 19 Nov 2004 13:09:28 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
Message-ID: <20041119120928.GE21483@wotan.suse.de>
References: <20041119005117.GM4943@stusta.de> <20041119085132.GB26231@wotan.suse.de> <419DC922.1020809@pobox.com> <20041119103418.GB30441@wotan.suse.de> <20041119120523.GA22981@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041119120523.GA22981@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 01:05:23PM +0100, Adrian Bunk wrote:
> On Fri, Nov 19, 2004 at 11:34:19AM +0100, Andi Kleen wrote:
> >...
> > In addition such a change is quite intrusive and I don't
> > think it's a good idea to do right now because it'll very
> > likely introduce bugs.
> >...
> 
> I's say it will fix some bugs and make some future bugs less likely.

I doubt it (and so far I did most of these changes)

-Andi
