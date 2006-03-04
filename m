Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752024AbWCDUhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbWCDUhJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 15:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbWCDUhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 15:37:09 -0500
Received: from stinky.trash.net ([213.144.137.162]:5597 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S1752024AbWCDUhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 15:37:07 -0500
Message-ID: <4409FA66.7010802@trash.net>
Date: Sat, 04 Mar 2006 21:36:54 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hadi@cyberus.ca
CC: Adrian Bunk <bunk@stusta.de>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] let NET_CLS_ACT no longer depend on	EXPERIMENTAL
References: <20060304160755.GB9295@stusta.de>  <4409C6BA.60803@trash.net> <1141498341.5185.32.camel@localhost.localdomain>
In-Reply-To: <1141498341.5185.32.camel@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> On Sat, 2006-04-03 at 17:56 +0100, Patrick McHardy wrote:
> 
>>Adrian Bunk wrote:
>>
>>>This option should IMHO no longer depend on EXPERIMENTAL.
>>>
>>
>>Yesterday I managed to crash my machine playing around with tc actions
>>within minutes. I haven't looked into it yet, but it seems it still
>>needs more testing.
> 
> 
> Simple: Fix the bug and submit a patch. If you cant find the cause post
> what you are doing. 

I'll fix it.

> What is the metric for going from experimental to non-experimental?
> I surely hope it doesnt come to some irrational reasoning like
> "Patrick found a bug"[1]. 

I think a sane metric is "opinion of people who know the code". But
I don't care much, I don't think many people care whether something
is maked experimental or not.

> [1]If you used half of that logic on netfilter it would still be
> experimental or rather should be demoted to experimental.

I'll take that as a compliment :)
