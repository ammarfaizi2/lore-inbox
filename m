Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263376AbTCNQ0t>; Fri, 14 Mar 2003 11:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263383AbTCNQ0t>; Fri, 14 Mar 2003 11:26:49 -0500
Received: from bitmover.com ([192.132.92.2]:28055 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263376AbTCNQ0s>;
	Fri, 14 Mar 2003 11:26:48 -0500
Date: Fri, 14 Mar 2003 08:37:27 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: John Jasen <jjasen@realityfailure.org>, Larry McVoy <lm@bitmover.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Marowsky-Bree <lmb@suse.de>,
       Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
Subject: Re: Never ever use word BitKeeper if Larry does not like you
Message-ID: <20030314163727.GE8937@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	John Jasen <jjasen@realityfailure.org>,
	Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lars Marowsky-Bree <lmb@suse.de>, Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	vojtech@suse.cz
References: <Pine.LNX.4.44.0303141120240.8584-100000@bushido> <1047659289.2566.109.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047659289.2566.109.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Check with your lawyers again, since Red Hat has posted in the past that 
> > 'similar' namings would be chased after. I think the example they used was 
> > 'Pink Fedora'.
> 
> Having a product name "confusingly similar" to another one _is_ grounds
> for trademark action.  See Lindows, Mobilix etc.  (And yes, of course,
> it's a very subjective thing in many cases.)
> 
> But simply comparing one product to another is not the same.
> 
> I'd expect using a name like "BitBucket" to be much more at risk of
> being a trademark infringement than merely claiming that a project "aims
> to be BitKeeper compatible" or "can read BitKeeper repositories."

But it can't read BK repositories in many cases.  We support compressed
repositories, it can't read those.  We support many corner cases which
SCCS didn't handle, it can't read those.  It can't reproduce all of the
extensions that we have added.  In other words, saying what Pavel has
is like BitKeeper is like saying cat is like Word because they both read
data off of disk.  

That's the whole point.  If we sit back and let people think that he has
something remotely similar to BK, it devalues BitKeeper in the mind of
those people.  Since this is a very complex system with lots of subtle
features, people easily get confused.  What Pavel has doesn't approach
the functionality of CVS, let alone BitKeeper, yet he is describing it
as a BitKeeper clone.  If we allow that, we're just shooting our brand
name dead.

It's amusing, perhaps, to relate that we have been on the other side
of this debate in the past.  We used to have a section in our comparisons
on ClearCase and we said that CC was no longer actively developed.  The
Rational lawyers kicked up a fuss, their view was different.  We had
said that because the product is basically done, it isn't rapidly evolving
the way a young product does, it's done.  But they do port it to new 
platforms and bug fix it and their (valid) position was that it was
actively developed.  We promptly fixed the web page, they signed off
the existing page, no fuss, no muss.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
