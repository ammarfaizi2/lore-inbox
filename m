Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265164AbUD3R5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265164AbUD3R5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 13:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbUD3R5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 13:57:06 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:53520 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265164AbUD3R5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 13:57:03 -0400
Message-ID: <4092948D.6030600@techsource.com>
Date: Fri, 30 Apr 2004 14:01:49 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
CC: Jeff Garzik <jgarzik@pobox.com>, Marc Boucher <marc@linuxant.com>,
       Sean Estabrooks <seanlkml@rogers.com>, koke@sindominio.net,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, riel@redhat.com,
       david@gibson.dropbear.id.au, torvalds@osdl.org, paul@wagland.net
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <Pine.LNX.4.44.0404301557230.4027-100000@einstein.homenet>
In-Reply-To: <Pine.LNX.4.44.0404301557230.4027-100000@einstein.homenet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tigran Aivazian wrote:
> On Fri, 30 Apr 2004, Jeff Garzik wrote:
> 
>>DriverLoader significantly lowers that cost, while not providing an open 
>>source solution at all.
> 
> 
> Ah, I see.... that makes a HUGE difference. Now I understand what the fuss
> is all about. So, that is why everyone jumped on Marc Boucher's throat
> trying to annihilate, humiliate, frighten by unsubstantiated allegations
> and generally grind him into tiny specks of dust, at the same time falsely
> pretending that all the fuss was only about that silly '\0' byte they 
> left in their license string (I wish they knew better not to do that --- 
> there are millions of ways to achieve what they want).


Nope.  The real objection was misleading people about the license of the 
module.  That part was clearly wrong.

The fact that it dilutes Linux is a side-objection, and we're not making 
an objection so much as a warning about the potential long-term effects. 
  This part isn't clearly wrong so much as something to be concerned about.

At least, that's MY opinion on it.

