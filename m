Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWEOMfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWEOMfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 08:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWEOMfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 08:35:47 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:32190 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750760AbWEOMfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 08:35:47 -0400
Date: Mon, 15 May 2006 14:35:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       Moxa Technologies <support@moxa.com.tw>, Alan Cox <alan@redhat.com>,
       Martin Mares <mj@ucw.cz>
Subject: Re: [PATCH] fix dangerous pointer derefs and remove pointless casts in MOXA driver
Message-ID: <20060515123545.GB26656@wohnheim.fh-wedel.de>
References: <200605140349.36122.jesper.juhl@gmail.com> <20060514141845.GB23387@mipter.zuzino.mipt.ru> <9a8748490605150253u3c69f030wd59f0619550d2060@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a8748490605150253u3c69f030wd59f0619550d2060@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006 11:53:07 +0200, Jesper Juhl wrote:
> On 14/05/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> >Please, don't make unrelated changes, ever.
> >
> Sorry about that.
> I know that's the general rule, but I guess I've been spoiled by
> having some of my recent patches merged that did a few trivial things
> all in one patch and people didn't seem to mind. I'll try to get out
> of that habbit again.

I _did_ mind.  Just not enough to complain. :)

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens
