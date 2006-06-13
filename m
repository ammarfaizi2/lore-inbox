Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932862AbWFMETE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932862AbWFMETE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 00:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWFMETE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 00:19:04 -0400
Received: from 1wt.eu ([62.212.114.60]:28936 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932862AbWFMETD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 00:19:03 -0400
Date: Tue, 13 Jun 2006 06:18:25 +0200
From: Willy Tarreau <w@1wt.eu>
To: David Miller <davem@davemloft.net>
Cc: kernel@linuxace.com, jesper.juhl@gmail.com, nick@linicks.net,
       vonbrand@inf.utfsm.cl, bernd@firmix.at, mf.danger@gmail.com,
       dwmw2@infradead.org, matti.aarnio@zmailer.org,
       linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Message-ID: <20060613041825.GC13255@w.ods.org>
References: <7c3341450606121410y7f2349e1y7d8ecf3f3873732@mail.gmail.com> <9a8748490606121506w43c8a45yf44d0c4120ae80c@mail.gmail.com> <20060613001101.GA24852@linuxace.com> <20060612.172623.35354043.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612.172623.35354043.davem@davemloft.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 05:26:23PM -0700, David Miller wrote:
> From: Phil Oester <kernel@linuxace.com>
> Date: Mon, 12 Jun 2006 17:11:01 -0700
> 
> > On Tue, Jun 13, 2006 at 12:06:52AM +0200, Jesper Juhl wrote:
> > > Making subscription to LKML a requirement would be a major barier for
> > > people who just want to shoot off a bug report or similar but who do
> > > not want to be subscribed (nor can be botherd to go through the
> > > motions to subscribe, or perhaps can't work out how to subscribe)...
> > > We want users to be able to submit bugreports to the list easily.
> > 
> > The rejection sent to non-subscribers could point them to a website
> > where they could submit a message via a webform (after correctly
> > entering the contents of a CAPTCHA).  
> 
> No way, too much work.  If plain email doesn't work, people will
> throw up their hands and say "why bother?"  We don't want to do
> one iota of something which will even possibly deter a bug report
> because we need as much information about bugs as possible.

I agree with you David. I had to report a bug to the NTP mailing list. I
got it back right in my face because I had not subscribed. Then I went
to thei bugzilla interface... What a counter-intuitive tool ! I was about
to give up at least 3 times. It took me at least 15 minutes to find how I
could report my bug and provide the patch in a usable form. I'm really
sure that a lot of bug reports get lost because of this !

I'd rather get a few spams on LKML than lose bug reports because of
discouraged users !

Cheers,
Willy

