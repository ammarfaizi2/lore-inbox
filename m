Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTFROLz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 10:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbTFROLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 10:11:05 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:34237 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265229AbTFROKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 10:10:12 -0400
Message-ID: <3EF07435.8020407@nortelnetworks.com>
Date: Wed, 18 Jun 2003 10:16:21 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: "David S. Miller" <davem@redhat.com>, babydr@baby-dragons.com,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Massive performance drop in routing throughput with 2.4.21 (62KB)
References: <20030616141806.6a92f839.skraw@ithnet.com>	<Pine.LNX.4.51.0306161444090.18129@dns.toxicfilms.tv>	<20030616145135.0ef5c436.skraw@ithnet.com>	<20030616151035.735fcaf2.martin.zwickel@technotrend.de>	<Pine.LNX.4.56.0306161413360.3114@filesrv1.baby-dragons.com>	<Pine.LNX.4.56.0306171518080.6807@filesrv1.baby-dragons.com>	<1055880260.19796.7.camel@rth.ninka.net> <20030618151034.0a84b2e2.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> On 17 Jun 2003 13:04:20 -0700
> "David S. Miller" <davem@redhat.com> wrote:

>>You can start by reporting the bug and all your debugging
>>informtion to the correct list.
>>
>>Networking developers DO NOT sit on linux-kernel, it's too high
>>volume for them.  So use the correct list to report such
>>problems.
>>
> 
> Maybe I should have made it a bit clearer in my original post to this thread:
> the thing is a show-stopper.

Did you see David's post?  He specifically said that the network 
developers are *not* on linux-kernel.  You would do better to send this 
to the linux network developers list, at netdev@oss.sgi.com.

You still haven't given the information that he asked for.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

