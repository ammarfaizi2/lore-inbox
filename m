Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbTGDKyK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 06:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbTGDKyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 06:54:10 -0400
Received: from hera.cwi.nl ([192.16.191.8]:33783 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265985AbTGDKyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 06:54:08 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 4 Jul 2003 13:08:32 +0200 (MEST)
Message-Id: <UTC200307041108.h64B8WE00112.aeb@smtp.cwi.nl>
To: hch@infradead.org, jari.ruusu@pp.inet.fi
Subject: Re: [PATCH] cryptoloop
Cc: Andries.Brouwer@cwi.nl, akpm@digeo.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch to jari:

> So get your code merged. Moaning about breaking out of tree code beeing
> broken by changes when an in-kernel alternative eists doesn't help.
>
> Either try to help improving what's in the tree or shut up.


Oh, Christoph - can't you just be a tiny bit more civil.

Here is an ungoing process of merging crypto/loop code.
You are perfectly aware of that - you complained about
every single stage - the rfc patch at the start was
too large, the whitespace in the next patch was distributed
incorrectly, also the third part had terrible bugs - I forget,
maybe there was a superfluous #include.

Now that you are very aware of this ongoing effort
of merging the loop stuff that so far lived as separate
patches outside the kernel tree, how can you say
"get your code merged"? That is precisely what we are
doing right now. Slowly. Step by step.


Andrew on the other hand apparently didnt know, and commented
on something that can be improved. Excellent. For this patch #3
that comment was not relevant, but no doubt we must try and
follow his good advice in some subsequent patch. Preferably
without breaking existing user space.


Try to follow Andrew's example - nice, friendly, constructive.
It is possible to be a good coder without being abusive.

Andries
