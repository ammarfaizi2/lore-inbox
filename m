Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWFOXMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWFOXMe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 19:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWFOXMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 19:12:34 -0400
Received: from animx.eu.org ([216.98.75.249]:31143 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1750738AbWFOXMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 19:12:33 -0400
Date: Thu, 15 Jun 2006 19:14:01 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: jdow <jdow@earthlink.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       nick@linicks.net, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Bernd Petrovitsch <bernd@firmix.at>, marty fouts <mf.danger@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Message-ID: <20060615231401.GA21203@animx.eu.org>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>, jdow <jdow@earthlink.net>,
	Jesper Juhl <jesper.juhl@gmail.com>, nick@linicks.net,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Bernd Petrovitsch <bernd@firmix.at>,
	marty fouts <mf.danger@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <027e01c68e74$76875910$0225a8c0@Wednesday> <30592.1150391118@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30592.1150391118@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> "jdow" (on Mon, 12 Jun 2006 16:03:46 -0700) wrote:
> >Greylist those who have not subscribed. Let their email server try
> >again in 30 minutes. For those who are not subscribed it should not
> >matter if their message is delayed 30 minutes. And so far spammers
> >never try again.
> 
> Not true.  I greylist and my recent logs show a pattern of spam code
> that tries 5 times at exactly 5 minute intervals, before finally giving
> up.  Other spam code tries two or three times at one hour intervals.
> All designed by spammers to bypass greylist systems.

I have yet to setup any greylisting for any of my systems yet, but I would
greylist, and if they came back an hour later and was in blacklists, I
wouldn't allow it.  This is one thing greylisting can do for you, defer it
until they are in blacklists.

Of course all rules need to be weighed for the server they are placed on.  I
would do the above on my domain since I'm the only user, I might not on big
ISP.

I have noticed spam from zombies that were not in RBLs when it came in and 5
minutes later, they are in RBLs.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
