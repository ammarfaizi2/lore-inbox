Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265121AbUD3QLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265121AbUD3QLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 12:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbUD3QLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 12:11:49 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:45471 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S265120AbUD3QKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 12:10:23 -0400
In-Reply-To: <40927417.6040100@nortelnetworks.com>
References: <Pine.LNX.4.44.0404301557230.4027-100000@einstein.homenet> <40927417.6040100@nortelnetworks.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DE44B86D-9AC0-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: Sean Estabrooks <seanlkml@rogers.com>, david@gibson.dropbear.id.au,
       Jeff Garzik <jgarzik@pobox.com>, miller@techsource.com, riel@redhat.com,
       koke@sindominio.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Tigran Aivazian <tigran@aivazian.fsnet.co.uk>, rusty@rustcorp.com.au,
       paul@wagland.net
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 12:10:16 -0400
To: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris,

people should, before insulting us publicly or make unsubstantiated 
claims that we "lie" or engage in "illegal" actions, perhaps consult a 
lawyer, and simultaneously use the opportunity to enquire about the 
meaning of "slander".

I repeat, the \0 is purely a technical workaround, done without any 
mischievous intent. Parts of the modules are indeed GPL, and the linked 
in binary-only modem code isn't. We didn't try to hide anything since 
the code containing the workaround is open-source, and we even 
explained back in February the purpose of this workaround on the public 
hsflinux mailing list, while suggesting that a patch should be sent to 
effectively take care of the problem. I even apologized to Rusty for 
not sending that patch ourselves.

Cordially
Marc

On Apr 30, 2004, at 11:43 AM, Chris Friesen wrote:

> Tigran Aivazian wrote:
>> On Fri, 30 Apr 2004, Jeff Garzik wrote:
>>> DriverLoader significantly lowers that cost, while not providing an 
>>> open source solution at all.
>> Ah, I see.... that makes a HUGE difference. Now I understand what the 
>> fuss
>> is all about. So, that is why everyone jumped on Marc Boucher's throat
>> trying to annihilate, humiliate, frighten by unsubstantiated 
>> allegations
>> and generally grind him into tiny specks of dust, at the same time 
>> falsely
>> pretending that all the fuss was only about that silly '\0' byte they 
>> left in their license string (I wish they knew better not to do that 
>> --- there are millions of ways to achieve what they want).
>
> Your statement is unsubstantiated.  Many companies try to work around 
> the GPL, or walk very close (and often over) the fine line of 
> compliance.  They want to get something for nothing, because that's 
> what companies are there for--to make money.  There aren't very many 
> altruistic for-profit companies.
>
> Personally, what sticks in my craw is the fact that this company did 
> something wrong, and then tried to defend its actions by claiming that 
> it was to make it easier for the customer.  That excuse doesn't 
> wash--what they did was *illegal*.  The fact that it also makes it 
> harder to get open-source drivers is a side effect for me.
>
> Chris
>
>
>

