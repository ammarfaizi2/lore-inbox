Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUD3Pp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUD3Pp1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 11:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbUD3Pp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 11:45:27 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:6354 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263089AbUD3PpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 11:45:25 -0400
Message-ID: <40927417.6040100@nortelnetworks.com>
Date: Fri, 30 Apr 2004 11:43:19 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
CC: Jeff Garzik <jgarzik@pobox.com>, Marc Boucher <marc@linuxant.com>,
       Sean Estabrooks <seanlkml@rogers.com>, koke@sindominio.net,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, riel@redhat.com,
       david@gibson.dropbear.id.au, torvalds@osdl.org, miller@techsource.com,
       paul@wagland.net
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

Your statement is unsubstantiated.  Many companies try to work around the GPL, or walk very close 
(and often over) the fine line of compliance.  They want to get something for nothing, because 
that's what companies are there for--to make money.  There aren't very many altruistic for-profit 
companies.

Personally, what sticks in my craw is the fact that this company did something wrong, and then tried 
to defend its actions by claiming that it was to make it easier for the customer.  That excuse 
doesn't wash--what they did was *illegal*.  The fact that it also makes it harder to get open-source 
drivers is a side effect for me.

Chris



