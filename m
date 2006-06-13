Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWFMN3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWFMN3R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 09:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWFMN3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 09:29:17 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:64951 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932092AbWFMN3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 09:29:16 -0400
Message-Id: <200606131328.k5DDSRd4003689@laptop11.inf.utfsm.cl>
To: "jdow" <jdow@earthlink.net>
cc: "Jesper Juhl" <jesper.juhl@gmail.com>, nick@linicks.net,
       "Bernd Petrovitsch" <bernd@firmix.at>,
       "marty fouts" <mf.danger@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter) 
In-Reply-To: Message from "jdow" <jdow@earthlink.net> 
   of "Mon, 12 Jun 2006 22:54:02 MST." <02f401c68ead$c69815a0$0225a8c0@Wednesday> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Tue, 13 Jun 2006 09:28:27 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 13 Jun 2006 09:28:27 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jdow <jdow@earthlink.net> wrote:
> From: "Horst von Brand" <vonbrand@inf.utfsm.cl>
> > jdow <jdow@earthlink.net> wrote:

> > [...]

> >> Greylist those who have not subscribed.
> > That is not easy to do.

> Somebody needs to write the code to make it easy to do for a list
> server. It should not be hard to do.

Great! Show us how. I'd be delighted to use it here.

> >>                                         Let their email server try
> >> again in 30 minutes. For those who are not subscribed it should not
> >> matter if their message is delayed 30 minutes. And so far spammers
> >> never try again.

> > Wrong. Greylisting does stop an immense amount of spam here, but a
> > lot comes through.

> So if it's not perfect it's not worth doing at all, eh?

Didn't say that. Spammers /are/ finding ways to fool greylisting, that is
all.

>                                                         Yet you think
> SPF, which is FAR less suited as a spam preventative, is a single
> point solution.

I don't know where you got the idea I consider SPF a "single point
solution". FYI, here we use greylisting, spamassassin, ClamAV (much junk is
malware), and blacklists (both local ones and via DNS). We analyzed SPF and
rejected it a while ago as unfixably broken. No "single point solution" in
sight, sadly.

>                 Double think was supposed to have come and gone in
> 1984, I thought.

Double think is alive and well, thank you very much.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
