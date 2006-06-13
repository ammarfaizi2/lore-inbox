Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWFMIk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWFMIk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 04:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWFMIk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 04:40:28 -0400
Received: from ns.firmix.at ([62.141.48.66]:5537 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750774AbWFMIk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 04:40:27 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: Bernd Petrovitsch <bernd@firmix.at>
To: jdow <jdow@earthlink.net>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jesper Juhl <jesper.juhl@gmail.com>, nick@linicks.net,
       marty fouts <mf.danger@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <02f401c68ead$c69815a0$0225a8c0@Wednesday>
References: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl>
	 <02f401c68ead$c69815a0$0225a8c0@Wednesday>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 13 Jun 2006 10:36:06 +0200
Message-Id: <1150187766.28123.13.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.126 () AWL,BAYES_00,FORGED_RCVD_HELO,FUZZY_AMBIEN
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 22:54 -0700, jdow wrote:
> From: "Horst von Brand" <vonbrand@inf.utfsm.cl>
> > jdow <jdow@earthlink.net> wrote:
[...]
> >> Greylist those who have not subscribed.
[...]
> >>                                         Let their email server try
> >> again in 30 minutes. For those who are not subscribed it should not
> >> matter if their message is delayed 30 minutes. And so far spammers
> >> never try again.
> > 
> > Wrong. Greylisting does stop an immense amount of spam here, but a lot
> > comes through.

On one low traffic domain, we perceived 50% less spam with greylisting.
But spam is rising.

> So if it's not perfect it's not worth doing at all, eh? Yet you think

It works now but the next generation viruses/trojans/.... will have real
MTA functionality (i.e. SMTP 100% correct) and it is not a problem since
the zombie nets are large enough that that won't hurt anyone really.

> SPF, which is FAR less suited as a spam preventative, is a single

No means alone will kill spam (except making email as such as expensive
as snail mail). So comparing different means makes no sense.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

