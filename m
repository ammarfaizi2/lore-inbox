Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbWFLR2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbWFLR2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWFLR2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:28:13 -0400
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:22880 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751604AbWFLR2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:28:12 -0400
Message-ID: <448DA442.3010905@sbcglobal.net>
Date: Mon, 12 Jun 2006 12:28:34 -0500
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: linux-kernel@vger.kernel.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
Followup-To: artusemrys@sbcglobal.net
To: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
References: <20060610222734.GZ27502@mea-ext.zmailer.org> <20060612090521.GE11649@merlin.emma.line.org>
In-Reply-To: <20060612090521.GE11649@merlin.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
> On Sun, 11 Jun 2006, Matti Aarnio wrote:
...
> SPF is a non-starter.
> 
> Perhaps you should consider having filters look at the *content* of
> messages. Does it fit how common messages look on vger lists? Or does it
> look like the usual spam? bogofilter can to it. qsf can do it. spamprobe
> can do it.  crm114 can do it.  Some of these (bogofilter for instance)
> can ascertain how much it's spam, how much it's wanted, or if it's
> undecided.
> 

This is a great point; spam on linux-kernel, of all places, is notable 
by what it looks like.  Subject headers don't look right, and the 
content bears very little resemblance to l-k ham.  Maybe hand-filtering 
is catching the stuff that appears adapted to spoof legitimate kernel 
mail, but if so, it has a great track record.  Spammers don't seem to be 
targeting linux-kernel patterns.  Heck, I can train thunderbird to 
filter spam correctly by content for linux-kernel.  Bayesian works well. 
  Since it runs through Yahoo first, I often have to fight Yahoo for my 
legitimate email; that may change my mileage.  However, the other 
notable characteristic is the fact that this list ignores spam.  If it 
has a reply, it may be a flame, it may be a troll, but it hasn't ever 
been spam in my experience.

Why pursue brokenness unless it's your last resort?  You can break a lot 
of eggs without making anything edible, let alone an omelette.

Matt
