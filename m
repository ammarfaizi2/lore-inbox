Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263165AbUJ1X55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbUJ1X55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 19:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbUJ1XoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 19:44:24 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:50044 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263107AbUJ1Xhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:37:35 -0400
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: DaMouse <damouse@gmail.com>
Subject: Re: [patch 1/1] uml: fix mainline lazyness about TTY layer patch
Date: Fri, 29 Oct 2004 01:36:13 +0200
User-Agent: KMail/1.7.1
Cc: "blaisorblade_spam@yahoo.it" <blaisorblade_spam@yahoo.it>,
       LKML <linux-kernel@vger.kernel.org>
References: <20041028200635.3366D7436@localhost> <1a56ea39041028132610a1579e@mail.gmail.com>
In-Reply-To: <1a56ea39041028132610a1579e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410290136.13385.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 22:26, DaMouse wrote:
> On Thu, 28 Oct 2004 22:04:51 +0200, blaisorblade_spam@yahoo.it
>
> <blaisorblade_spam@yahoo.it> wrote:
> > While changing the TTY layer, an API parameter was removed, so it was
> > removed by almost all calls, changing their prototype. But one use of one
> > such function was not updated, breaking UML compilation. This is the fix.
> >
> > Should go in directly - trivial fix.
> >
> > Thanks for the breakage, too :-).

>
> http://dictionary.reference.com/search?q=lazyness
> NOW who's lazy :P

Ok, I've flamed a bit, and I get it back.

I'm not English, however that does not qualify as a good reason.

> -DaMouse
> -- 
> I know I broke SOMETHING but its their fault for not fixing it before me

Is that the signature or the actual answer :-)?

However, let's code well, ok? (I don't know whether you're the author, but 
however, that's not the problem).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
