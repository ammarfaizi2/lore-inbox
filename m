Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVJ2WH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVJ2WH4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVJ2WH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:07:56 -0400
Received: from electra.cc.umanitoba.ca ([130.179.16.23]:52964 "EHLO
	electra.cc.umanitoba.ca") by vger.kernel.org with ESMTP
	id S932465AbVJ2WHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:07:55 -0400
Message-ID: <4363F2B5.6090309@cc.umanitoba.ca>
Date: Sat, 29 Oct 2005 17:07:49 -0500
From: Mark Jenkins <umjenki5@cc.umanitoba.ca>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is sharpzdc_cs.o not a derivitive work of Linux?
References: <43625208.60703@cc.umanitoba.ca> <200510290410.48454.rob@landley.net>
In-Reply-To: <200510290410.48454.rob@landley.net>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

It is wonderful that a day will come when most modules will need to use
a symbol with attached documentation that says, "if you this symbol,
your code will be a derivative work, and by extension you must license
it under a GNU GPL compatible license".

A cynical person would respond to this and say "if somebody comes along
and uses one of those symbols in a proprietary module, the Linux
developers will let them get away with it".

I hold no such cynicism. I believe the Linux developers would act to
enforce their license in such a case.

This high regard that I have for the Linux developers is why I'm willing
to raise questions about a "binary only" module, despite the fact that
it doesn't use any symbols labeled EXPORT_SYMBOL_GPL. Linus makes it
clear that one can not conclude that he and others will say such a
module is *not* a derivative work. His position was that modules *are*
derivative works, unless a strong counter argument is made.
(see http://people.redhat.com/arjanv/COPYING.modules)

Therefor, if the Linux developers are faced with a module like
sharpzdc_cs.o, and if they conclude that good evidence is unavailable
that it is *not* a derivative work, I believe they would be willing to
listen to a complaint that their license of choice is not being
followed, and act on that complaint if they felt it was valid.

I will reply again later with an attempt to compare the criteria
available here:
http://people.redhat.com/arjanv/COPYING.modules
against the behavior of sharpzdc_cs.o and Sharp's distribution behavior.

In particular, I would like help with this part of it,
"anything that has knowledge of and plays with fundamental internal
   Linux behavior is clearly a derived work. If you need to muck around
   with core code, you're derived, no question about it.
"
as I am not a Linux hacker.


Mark Jenkins
