Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWFBAUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWFBAUG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 20:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWFBAUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 20:20:05 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:47573 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750706AbWFBAUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 20:20:04 -0400
Date: Fri, 2 Jun 2006 02:19:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: "Martin J. Bligh" <mbligh@google.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <447F571D.6000000@mbligh.org>
Message-ID: <Pine.LNX.4.64.0606020104390.32445@scrub.home>
References: <20060531211530.GA2716@elte.hu> <447E0A49.4050105@mbligh.org>
 <20060531213340.GA3535@elte.hu> <447E0DEC.60203@mbligh.org>
 <20060531215315.GB4059@elte.hu> <447E11B5.7030203@mbligh.org>
 <20060531221242.GA5269@elte.hu> <447E16E6.7020804@google.com>
 <20060531223243.GC5269@elte.hu> <447E1A7B.2000200@google.com>
 <20060531225013.GA7125@elte.hu> <Pine.LNX.4.64.0606011222230.17704@scrub.home>
 <447EFE86.7020501@google.com> <Pine.LNX.4.64.0606011659030.32445@scrub.home>
 <447F084C.9070201@google.com> <Pine.LNX.4.64.0606011742500.32445@scrub.home>
 <447F1BE4.5040705@mbligh.org> <Pine.LNX.4.64.0606012200260.32445@scrub.home>
 <447F571D.6000000@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Jun 2006, Martin J. Bligh wrote:

> > Well, if you don't want to enable a number of options, it's still better to
> > hide them completely. There are number of options by reorganizing the debug
> > menu a little, it only depends if we're talking here are about a -mm only
> > crutch or something which might be useful to more than a handful of people.
> > A few extra config options are not really a problem as long as they are
> > logically grouped together (instead of having to enable random options all
> > over the place).
> 
> How is the user meant to know which of your config options a particular
> option is hidden under?

I don't quite understand where you want to go with this question. What do 
you consider an easy to find option? We have thousands of config options, 
they have to be organized somehow, so they are always hidden somewhere.
Currently the debug menu is more a random collection of options, with a 
little organization it actually can make things easier to find, while 
still allowing a simple menu for the occasional user and an advanced menu.

> Seems there are two isses - whether the naming is meaningful or not,
> and whether you want to hide options under other options,or just flip
> defaults ... does that sound correct?

With my suggestion I was more concentrating on the latter (the general 
organisation of the menu options) than the actual wording.

bye, Roman
