Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUAVQ4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 11:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUAVQ4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 11:56:49 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:43151 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264586AbUAVQ4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 11:56:47 -0500
Message-ID: <401000C1.9010901@blue-labs.org>
Date: Thu, 22 Jan 2004 11:56:33 -0500
From: David Ford <david+hb@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jes Sorensen <jes@wildopensource.com>
CC: Zan Lynx <zlynx@acm.org>, Andreas Jellinghaus <aj@dungeon.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Confirmation Spam Blocking was: List 'linux-dvb' closed
 to public posts
References: <ecartis-01212004203954.14209.1@mail.convergence2.de>	<20040121194315.GE9327@redhat.com>	<Pine.LNX.4.58.0401211155300.2123@home.osdl.org>	<1074717499.18964.9.camel@localhost.localdomain>	<20040121211550.GK9327@redhat.com>	<20040121213027.GN23765@srv-lnx2600.matchmail.com>	<pan.2004.01.21.23.40.00.181984@dungeon.inka.de>	<1074731162.25704.10.camel@localhost.localdomain> <yq0hdyo15gt.fsf@wildopensource.com>
In-Reply-To: <yq0hdyo15gt.fsf@wildopensource.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Considering that Bayesian filters are useless against the new spam that 
is proliferating these days, that's laughable.  Spam now comes with a 
good 5-10K of random dictionary words.

I use challenge-response and the only spam that gets to my inbox now 
comes from lists.  I pre-listed all my buddies in my whitelist, only new 
senders that I'm not yet aware of have to go thru the challenge process.

If you can't handle clicking on a link to authorize your email, then I'm 
not interested in your email. If that tiny few seconds  of effort is a 
waste of your time, then writing your email to me was also a waste of 
your time.

Getting well over 900 spams a day on average, almost double on mondays, 
just isn't my cup of tea.  There is no one solution to spam.  I 
pre-filter with spamassassin using all it's tools, anything scoring high 
automatically gets /dev/nulled.  Those include bayesian, pattern 
matches, DNSBL, etc. Next I attempt to filter viruses and the like.  The 
remainder goes through TMDA.

Spamassassin cuts it down to less than 100 typically, and of that, about 
50 are on the border.  TMDA takes care of the rest.  The majority of 
spam making it through SA is the dictionary attack spam.  My 
retro-impact on spam is minimized.

It's getting really annoying because spammers are taking input emails 
like LKML and making word lists out of the emails.

Hmm, 900 spams in my mailbox, or half a dozen due to lists.  I'll take 
the second.

David

Jes Sorensen wrote:

>>>>>>"Zan" == Zan Lynx <zlynx@acm.org> writes:
>>>>>>            
>>>>>>
>
>Zan> On Wed, 2004-01-21 at 16:40, Andreas Jellinghaus wrote:
>  
>
>>>On Wed, 21 Jan 2004 21:44:37 +0000, Mike Fedyk wrote: > What do you
>>>think about individual email (non-list) using a confirmation >
>>>based spam blocking system.
>>>
>>>for personal email it is plain asocial. it tells me that a person
>>>does not want to receive mail from me.
>>>      
>>>
>
>Zan> For me, that isn't what it says at all.  It tells me that he or
>Zan> she is tired of receiving and sorting all of the spam every day.
>Zan> Since I feel exactly the same way about spam, I cooperate and
>Zan> reply with a confirmation.
>
>I've had people pull the authentication game on me before. I just
>stopped replying to them, waste of my time.
>
>Fixing the spam problem is a lot easier without losing contact with
>all your friends in the proces:, train your Bayesian filters and be
>done with it. Mine were a mess, deleted all the data and fed 10 days
>of spam and some proper mail through sa-learn. Since then I have seen
>1 spam make it through during the last week, it used to be 20-40/day
>(and some 200-300/day caught by the filters).
>
>  
>
