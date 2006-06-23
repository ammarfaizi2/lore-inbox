Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWFWO7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWFWO7p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWFWO7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:59:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61614 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750852AbWFWO7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:59:42 -0400
Date: Fri, 23 Jun 2006 07:59:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: Junio C Hamano <junkio@cox.net>, Git Mailing List <git@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
In-Reply-To: <Pine.LNX.4.63.0606231305000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Message-ID: <Pine.LNX.4.64.0606230756050.6483@g5.osdl.org>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org>
 <Pine.LNX.4.63.0606231305000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jun 2006, Johannes Schindelin wrote:
> > 
> >  - default to red/green for old/new lines. That's the norm, I'd think.
> 
> ... and which happens to be useless for 10% of the male population (and 
> even more if you look specifically at Asian people). But then, I just 
> pasted that part from somewhere else.

Sure. 

(Although I think it's 7% in general, and more in certain populations, 
some Western European countries included)

Which just means that we should have some way to let people set their own 
colors.

The _default_ should be the one people expect, though.

		Linus
