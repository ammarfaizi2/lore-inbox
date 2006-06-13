Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932802AbWFMDBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbWFMDBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 23:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932803AbWFMDBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 23:01:11 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53476 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932802AbWFMDBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 23:01:10 -0400
Message-Id: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl>
To: "jdow" <jdow@earthlink.net>
cc: "Jesper Juhl" <jesper.juhl@gmail.com>, nick@linicks.net,
       "Horst von Brand" <vonbrand@inf.utfsm.cl>,
       "Bernd Petrovitsch" <bernd@firmix.at>,
       "marty fouts" <mf.danger@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>,
       "Matti Aarnio" <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter) 
In-Reply-To: Message from "jdow" <jdow@earthlink.net> 
   of "Mon, 12 Jun 2006 16:03:46 MST." <027e01c68e74$76875910$0225a8c0@Wednesday> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 12 Jun 2006 23:00:02 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 12 Jun 2006 23:00:20 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jdow <jdow@earthlink.net> wrote:

[...]

> Greylist those who have not subscribed.

That is not easy to do.

>                                         Let their email server try
> again in 30 minutes. For those who are not subscribed it should not
> matter if their message is delayed 30 minutes. And so far spammers
> never try again.

Wrong. Greylisting does stop an immense amount of spam here, but a lot
comes through.

>                  That's FAR more likely to nail spam than using SPF
> as a singular measure. It doesn't even require the remote DNS
> transaction to check an SPF record.

Right.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
