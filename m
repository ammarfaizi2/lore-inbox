Return-Path: <linux-kernel-owner+w=401wt.eu-S964956AbWLMQOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWLMQOy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWLMQOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:14:54 -0500
Received: from orion2.pixelized.ch ([195.190.190.13]:53547 "EHLO
	mail.pixelized.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964956AbWLMQOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:14:53 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 11:14:53 EST
Message-ID: <458025A5.2070001@cateee.net>
Date: Wed, 13 Dec 2006 17:09:09 +0100
From: "Giacomo A. Catenazzi" <cate@cateee.net>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Postgrey experiment at VGER
References: <200612131711.28292.a1426z@gawab.com>
In-Reply-To: <200612131711.28292.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Trond Myklebust wrote:
>> On Wed, 2006-12-13 at 11:25 +0200, Dumitru Ciobarcianu wrote:
>>> On Wed, 2006-12-13 at 01:50 +0200, Matti Aarnio wrote:
>>>> I do already see spammers smart enough to retry addresses from
>>>> the zombie machine, but that share is now below 10% of all emails.
>>>> My prediction for next 200 days is that most spammers get the clue,
>>>> but it gives us perhaps 3 months of less leaked junk.
> 
> Great!
> 
>>> IMHO this is only an step in an "arms race".
>>> What you will do in three months, remove this check because it will
>>> prove useless since the spammers will also retry ? If yes, why install
>>> it in the first place ?
>> Why ever do anything? You're going to die eventually anyway...
> 
> Right!  The problem here is that it may do more harm than good.
> 
> May I suggest a smarter way to filter these spammers, by just whitelisting 
> email addresses of valid posters, after sending a confirmation for the first 
> post.  Now if these spammers get smart, and start using personal email 
> addresses, I would certainly expect some real action by abused email address 
> owners.

So a challange to the kernel hackers: build a mail filtering/proxy 
system, a' la BSD.
I don't remember the specification and features, but IIRC the
netfilter is not enough to do the graylisting (but pf was).
Someone has some hints what kernel can do in the fight against
spam?

ciao
	cate
