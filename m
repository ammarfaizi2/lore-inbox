Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266445AbUAVWSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 17:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbUAVWSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 17:18:16 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:46344 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S266445AbUAVWSH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 17:18:07 -0500
Date: Thu, 22 Jan 2004 14:18:02 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Confirmation Spam Blocking was: List 'linux-dvb' closed to public posts
Message-ID: <20040122221802.GD12666@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0401211155300.2123@home.osdl.org> <1074717499.18964.9.camel@localhost.localdomain> <20040121211550.GK9327@redhat.com> <20040121213027.GN23765@srv-lnx2600.matchmail.com> <pan.2004.01.21.23.40.00.181984@dungeon.inka.de> <1074731162.25704.10.camel@localhost.localdomain> <yq0hdyo15gt.fsf@wildopensource.com> <401000C1.9010901@blue-labs.org> <Pine.LNX.4.58.0401221034090.4548@dlang.diginsite.com> <40101B1E.3030908@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40101B1E.3030908@blue-labs.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message may contain content offensive to Atheists and servants of false gods.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 01:49:02PM -0500, David Ford wrote:
> I've been amusing myself once or twice a week by studying some of these 
> emails.  Due to the use of common words just like your email below, 
> bayesian score is far too low (granting it a negative point value in SA).
> 
> The problem is that properly trained is too fluid.  It'd be far more 
> achievable if I only talked geek..  Or if I only talked automotive.  Or 
> that I only talked medical.  However, my "vocabulary" is far to varied 
> to train a bayesian filter that the use of medical terms, computer 
> terms, or a given topic, is taboo.
> 
> It cuts the gray area far to close to the middle of the road and thus 
> makes marking the email as probable spam useless.  All I'm doing now is 
> wasting CPU because in the end I'm doing the job of dealing with the 
> spam myself.

Most of the spam using that technique get flagged on other
rules so they get scores of at least 8 but i've been
considering writing a rule to catch them and up the score.

Beyes is the wrong aproach for those random words from the
dictionary blocks.

Those i've seen seem to be a long string of words all longer
than 4 characters.  A rule that gave a score of based on the
number of consecutive words longer than some number or
characters would catch those fairly easily.  If i get
annoyed enough i may figure out how to write such a rule.

On the downside, once a rule becomes common to catch these
random word lists the spammers will start salting the lists
with short common words.  Then when we get something that
somehow measures semantic content they will shift to random
random sentence construction and/or quotations.

What we need is a bounty on these scum.  $1000 fine per
reported recipient with half going to the reporter would be
nice.

> David Lang wrote:
> 
> >On Thu, 22 Jan 2004, David Ford wrote:
> > 
> >
> >>Considering that Bayesian filters are useless against the new spam that
> >>is proliferating these days, that's laughable.  Spam now comes with a
> >>good 5-10K of random dictionary words.
> >>   
> >>
> >so we need to extend the Bayesian filters to deal with multi-word combos,
> >how many legit mail has those dictionary words in them? properly traind
> >their presence should help identify the spam.
> >
> >not that you will ever see this (other then through the list) as I won't
> >respond to your confirmation message.
> >
> >David Lang
> > 
> >

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
