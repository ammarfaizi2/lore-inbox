Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWIHPEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWIHPEB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 11:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWIHPEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 11:04:01 -0400
Received: from nef2.ens.fr ([129.199.96.40]:15882 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1750804AbWIHPEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 11:04:00 -0400
Date: Fri, 8 Sep 2006 17:03:56 +0200
From: David Madore <david.madore@ens.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] new capability patch, version 0.4.2 (now with fs support), part 3/4
Message-ID: <20060908150356.GA12931@clipper.ens.fr>
References: <20060908042205.GD24135@clipper.ens.fr> <20060908042553.GF24135@clipper.ens.fr> <20060908144144.GA17854@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908144144.GA17854@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 08 Sep 2006 17:03:56 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 04:41:44PM +0200, Pavel Machek wrote:
> Well, for merge you'll need to sign-off and put explanation to each
> patch. Link is not enough, because it will end in git.

You'll have to excuse me for my ignorance: I have some knowledge of
how git and the kernel work as programs, but none at all of how they
are actually managed by the Powers That Be.  So, what does it mean to
"sign off", where should I append the explanations, which git
repository will/might it end in, and how am I supposed to do things
the right way?  I mean, so far I'm just expecting people to read the
patch and perhaps test it, but certainly not commit it anywhere
"serious"...

Pointers are an acceptable answer, of course.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
