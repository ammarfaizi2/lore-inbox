Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264713AbRFVKoy>; Fri, 22 Jun 2001 06:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264714AbRFVKoo>; Fri, 22 Jun 2001 06:44:44 -0400
Received: from t2.redhat.com ([199.183.24.243]:17404 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264713AbRFVKoa>; Fri, 22 Jun 2001 06:44:30 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200106211814.f5LIEgK04880@snark.thyrsus.com> 
In-Reply-To: <200106211814.f5LIEgK04880@snark.thyrsus.com> 
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 22 Jun 2001 11:44:24 +0100
Message-ID: <17687.993206664@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@snark.thyrsus.com said:
>  Earlier today I was contacted by a principal at a well-known Linux
> company who was in a mild panic over recent arguments by Alan Cox and
> David Miller.  This company (not VA or Red Hat, BTW) fears that their
> customers will run from Linux if they get the idea that linking
> drivers to the kernel might force them open. 

I'm not going to join the amateur lawyers' society debate about this. But I 
will point out that I disagree with your intentions here.

Personally, I don't _want_ authors or users of binary modules to be reassured.
I want them to write open source code, or go away. And I don't think I'm 
alone in that.

I think Linus said it best...

On 7 Feb 1999, at 08:15:24 GMT, Linus Torvalds said:
> Basically, I want people to know that when they use binary-only modules,
> it's THEIR problem.  I want people to know that in their bones, and I
> want it shouted out from the rooftops.  I want people to wake up in a
> cold sweat every once in a while if they use binary-only modules. 

Large companies are now basing their design and purchasing choices on the
availability of _real_ Linux support; not just binary-only drivers. Even if 
we _are_ primarily motivated by the desire to increase the market share of 
Linux (which is something I don't concede anyway), then we still don't lose 
much by letting binary-module people continue to sweat. 

--
dwmw2


