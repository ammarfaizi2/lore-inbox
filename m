Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030430AbVJEXSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030430AbVJEXSo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbVJEXSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:18:44 -0400
Received: from postman.ripe.net ([193.0.0.199]:60586 "EHLO postman.ripe.net")
	by vger.kernel.org with ESMTP id S1030430AbVJEXSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:18:44 -0400
Message-ID: <43445F51.7090403@colitti.com>
Date: Thu, 06 Oct 2005 01:18:41 +0200
From: Lorenzo Colitti <lorenzo@colitti.com>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
References: <200510032339.08217.rjw@sisk.pl> <20051003231715.GA17458@elf.ucw.cz> <200510041711.13408.rjw@sisk.pl> <20051004205334.GC18481@elf.ucw.cz> <1128465272.6611.75.camel@localhost> <20051005084141.GB22034@elf.ucw.cz> <434443D9.3010501@colitti.com> <20051005224418.GA22781@elf.ucw.cz> <4344599B.7060308@colitti.com> <20051005225727.GE22781@elf.ucw.cz> <20051005230045.GA22906@elf.ucw.cz>
In-Reply-To: <20051005230045.GA22906@elf.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-RIPE-Spam-Level: 
X-RIPE-Spam-Tests: ALL_TRUSTED,BAYES_20
X-RIPE-Spam-Status: U 0.284903 / -5.3
X-RIPE-Signature: 7766324298fc01aa05818794246580fb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> "Cool, so you have done 100% of work and now it is stable, fast and
> tested. You only need to do 200% more work to get it merged".
> 
> Merging into kernel is not easy, sorry.

Of course. I was just saying that it might be better for users if you, 
Nigel and the other parties involved collaborated on getting suspend2 
merged instead of working on 2 or 3 separate implementations. My gut 
feeling is that it would be quicker to do that than to nail the sucky 
low-level bugs that are bound to come up when developing the new uswsusp 
framework.

And now, since there's nothing I can actually do to help this - you 
can't learn to be a kernel hacker in two weeks - I'll shut up. But I 
just wanted to remind everyone involved that from a user's perspective, 
it would be great if suspend2 were merged.

It works, it's fast, it's stable, and it does what users want. That's a 
strong combination. It would be really good if you could work together 
to merge it.


Cheers,
Lorenzo

-- 
http://www.colitti.com/lorenzo/
