Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283409AbRLRBYL>; Mon, 17 Dec 2001 20:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283445AbRLRBXx>; Mon, 17 Dec 2001 20:23:53 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:46298 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S283439AbRLRBXk>;
	Mon, 17 Dec 2001 20:23:40 -0500
Date: Mon, 17 Dec 2001 17:23:35 -0800
To: Pawel Kot <pkot@linuxnews.pl>
Cc: jt@hpl.hp.com, Martin Diehl <lists@mdiehl.de>,
        Dag Brattli <dagb@cs.uit.no>, linux-kernel@vger.kernel.org,
        linux-irda@pasta.cs.uit.no
Subject: Re: [BUG()] IrDA in 2.4.16 + preempt
Message-ID: <20011217172335.A3950@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20011217161056.F3699@bougret.hpl.hp.com> <Pine.LNX.4.33.0112180214490.662-100000@urtica.linuxnews.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112180214490.662-100000@urtica.linuxnews.pl>; from pkot@linuxnews.pl on Tue, Dec 18, 2001 at 02:16:16AM +0100
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 02:16:16AM +0100, Pawel Kot wrote:
> On Mon, 17 Dec 2001, Jean Tourrilhes wrote:
> 
> > 	I'm surprised the fix of Martin didn't work...
> 
> It did in fact. My apologiese. I have applied it to the wrong kernel tree
> :/

	No comment ;-)

> Thanks Martin.
> 
> Any chance to have this patch in 2.4.17?
> 
> pkot

	You see, I try to be a good citizen (even if sometime I feel
very "emotional" about dropped patches). There is already a good chunk
of IrDA patches in 2.4.17, so this will wait 2.4.18. Moreover, this is
"rc1", and I make a point of always sending my patches at the
beggining of the "pre" series and batched.
	I have already another IrDA minor cleanup sent to me by Kai
Germaschewski. I'll batch that together. It's not like it's urgent...
	Regards,

	Jean
