Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318860AbSHEUAp>; Mon, 5 Aug 2002 16:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318861AbSHEUAp>; Mon, 5 Aug 2002 16:00:45 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:58056 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318860AbSHEUAo>;
	Mon, 5 Aug 2002 16:00:44 -0400
Date: Mon, 5 Aug 2002 13:04:18 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-ac4
Message-ID: <20020805200418.GA10287@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20020805174646.GH10011@bougret.hpl.hp.com> <1028579501.18478.74.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028579501.18478.74.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 09:31:41PM +0100, Alan Cox wrote:
> On Mon, 2002-08-05 at 18:46, Jean Tourrilhes wrote:
> > Alan Cox wrote :
> > >
> > > Linux 2.4.19-ac2
> > > o	Fix __FUNCTION__ in rest of irda drivers	(me)
> > > o	Fix __FUNCTION__ in some more net/irda bits	(me)
> > 
> > 	Would you mind sending those patches to me so that I can push
> > them toward 2.5.X at my next update ? I would hate to do the same job
> > twice. Thanks...
> > 
> > 	Also : I'm planning to dump some of my IrDA patch queue to
> > Marcelo real soon. I would hate to see my bug fixes colliding with
> > your cosmetic changes. Could you tell me the status of those fixes
> > with respect to Marcelo ?
> 
> I can send them to Marcelo or I can send them to you. The stuff I sent
> so far I cc'd to Dag Brattli since he's in maintainers. I've most but
> not all of irda done. Just tell me which way around you want to do it

	Well, I was mostly talking of 2.5.X, and as far a I know
Marcelo is still not doing it.
	I was planning to send my IrDA fixes today (or tommorow), they
are already on my web pages but I need to test them again, so if you
want to do it yourself maybe you can wait pre2. But that depend on
what Marcelo is doing with my patches.

> Alan

	Have fun...

	Jean
