Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUD1U0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUD1U0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUD1UGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:06:51 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:33243 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S261661AbUD1TbO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:31:14 -0400
In-Reply-To: <408FEBCA.70607@techsource.com>
References: <20040427165819.GA23961@valve.mbsi.ca> <1083107550.30985.122.camel@bach> <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com> <20040428002516.GC3272@zax> <677BC9FC-98B1-11D8-85DF-000A95BCAC26@linuxant.com> <408FEBCA.70607@techsource.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <975460FA-994A-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Wed, 28 Apr 2004 15:31:05 -0400
To: Timothy Miller <miller@techsource.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Timothy,

I am truly sorry about the concern this has caused, have already 
publicly apologized for not submitting a patch to properly correct the 
issue when the workaround was implemented, and proposed a change to the 
modem drivers that should go in as soon as possible to restore tainting 
and one instance of the warning messages while avoiding the flood.

At the same time, I think that the "community" should, without 
relinquishing its principles, be less eager before getting the facts to 
attack people and companies trying to help in good faith, and be more 
realistic when it comes to satisfying practical needs of ordinary 
users.

Sincerely
Marc

--
Marc Boucher
Linuxant inc.

On Apr 28, 2004, at 1:37 PM, Timothy Miller wrote:
>
> Marc Boucher wrote:
>
>> In an enterprise, customers always come first. Nonetheless, I don't
>> believe that this issue had a significant impact on kernel developers.
>> Had their support burden been significantly increased by our products,
>> the issue would have come up much sooner.
>
> This has all deteriorated into childish bickering rather than 
> meaningful debate.
>
> The problem is that Linuxant or whoever has done something which is 
> misleading and violates a tenet of the GPL and the module interface of 
> the Linux kernel.
>
> There may be technical reasons which excuse this, but in the end, 
> Linuxant needs to correct their (unintentional) error and move on.  In 
> this society, if you violate copyright and get caught, you get 
> slammed.  You've been caught and slammed.  Fortunately, no one is 
> suing you over it.
>
> But spending your time arguing about it rather than making it right is 
> only making you look like a jerk.  At this point, no one cares about 
> your excuses for why you did it -- excuses accepted, technical reasons 
> understood, we don't blame you for what you did in the PAST.
>
> If I were in your position, I would say, "I'm sorry.  I understand the 
> problem, and I will fix it as soon as possible."  THAT would be a 
> professional and ethical thing to do.  It's also a good way to get on 
> the GOOD side of the Linux community.  Everyone makes mistakes; what 
> matters is how they DEAL with those mistakes.
>

