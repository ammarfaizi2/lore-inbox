Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbUD1UIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbUD1UIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUD1UHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:07:00 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:13574 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261752AbUD1Tmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:42:31 -0400
Message-ID: <40900A28.2030506@techsource.com>
Date: Wed, 28 Apr 2004 15:46:48 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <1083107550.30985.122.camel@bach> <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com> <20040428002516.GC3272@zax> <677BC9FC-98B1-11D8-85DF-000A95BCAC26@linuxant.com> <408FEBCA.70607@techsource.com> <975460FA-994A-11D8-85DF-000A95BCAC26@linuxant.com>
In-Reply-To: <975460FA-994A-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc Boucher wrote:
> 
> Timothy,
> 
> I am truly sorry about the concern this has caused, have already 
> publicly apologized for not submitting a patch to properly correct the 
> issue when the workaround was implemented, and proposed a change to the 
> modem drivers that should go in as soon as possible to restore tainting 
> and one instance of the warning messages while avoiding the flood.

I was not personally offended, but I hope what you said here is taken by 
others as a good-faith gesture.

> 
> At the same time, I think that the "community" should, without 
> relinquishing its principles, be less eager before getting the facts to 
> attack people and companies trying to help in good faith, and be more 
> realistic when it comes to satisfying practical needs of ordinary users.

This is just part of the community, something which you should learn to 
take advantage of.  It's part of an impressive system of checks and 
balances.

A major principle of internet communication is that people will say 
venomous things in email which they would never say to you in person. 
You have to take what they say for what it MEANS, not what it looks like.

If you're flamed, particularly in a forum like LKML, pay attention to 
the meat of what the person is saying.  If the person is right, GREAT. 
If the person has completely misunderstood the situation, let it go.

And then, don't get drawn into endless debate defending yourself to 
every comment that people make.  Sometimes, it's best to just summarize 
the situation, acknowledge people's complaints, explain which ones are 
factual, and explain that you're working on a solution.

There are a number of people on LKML who seem to do an amazing job of 
getting to the point in a debate.  Take Theodore Ts'o, for example.  In 
particular, his posts are a pleasure to read because they are so clear 
and full of knowledge.

