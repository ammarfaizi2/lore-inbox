Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268247AbUHXTc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268247AbUHXTc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUHXTc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:32:56 -0400
Received: from mail.dif.dk ([193.138.115.101]:12744 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268247AbUHXTbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:31:09 -0400
Date: Tue, 24 Aug 2004 21:36:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Shouldn't kconfig defaults match recommendations in help text?
In-Reply-To: <Pine.LNX.4.61.0408242042150.12756@scrub.home>
Message-ID: <Pine.LNX.4.61.0408242133440.2770@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0408232050450.3767@dragon.hygekrogen.localhost>
 <Pine.LNX.4.61.0408242042150.12756@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Roman Zippel wrote:

> Hi,
> 
> On Mon, 23 Aug 2004, Jesper Juhl wrote:
> 
> > Would patches to change default configuration choices to match the 
> > recommendation given in the help text (if any) be acceptable? If not I'd 
> > be interrested in the reasons why not.
> 
> Different configurations require different defaults and the current help 
> text is rather static. The basic problem is that most recommendations are 
> rather ix86 specific. I think an overuse of defaults is the wrong way to 
> go.
> 
I'll be sure to keep that in mind.
I will not go crazy with this and make everything default to the 
recommendations but try and only do it where it actually makes good sense 
- I'm hoping for people to review these patches and comment on the 
"saneness". 

--
Jesper Juhl


