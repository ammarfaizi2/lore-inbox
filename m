Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWEZQek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWEZQek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWEZQdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:33:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:807 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751065AbWEZQd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:33:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=p5PvP43YKmxrt/Fw2c+pTD7So0iaf6ziiuK99CP8kXBQvWBEolOf19slQ6GX4e1ooOVLDjvDPvlTRd0y/t6jbFUC4wRW7QacL0FEjyc6hRdlnUOUW+V2/7IU5vrljoVpC/P8WGnVbl/I38GSeLVO/T5/2FHncm9nIMRP7FWuh/k=
Message-ID: <44772D99.2070001@gmail.com>
Date: Fri, 26 May 2006 19:32:25 +0300
From: Anssi Hannula <anssi.hannula@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, linux-joystick@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 03/11] input: new force feedback interface
References: <20060515211229.521198000@gmail.com>	<20060515211506.783939000@gmail.com>	<20060517222007.2b606b1b.akpm@osdl.org>	<4471E259.7080609@gmail.com>	<4474392F.1030809@gmail.com> <20060524174910.5b066ee5.akpm@osdl.org>
In-Reply-To: <20060524174910.5b066ee5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Anssi Hannula <anssi.hannula@gmail.com> wrote:
> 
>>>BTW, what is the best way to send corrected patches for this patchset?
>>>Probably as a reply to the individual patches?
>>>
>>
>>Hmm, I think it is easier to just send the whole updated set...
>>
>>I'm going to do all the changes discussed and then send the set probably
>>tomorrow or in the weekend.
>>
> 
> Yes, that's fine.  Once patches have matured a bit, incremental (and
> fine-grained) updates are preferred.  And I'll often turn
> wholesale-replacement-attempts into incremental updates, so we can see what
> changed.
> 
> But at this stage, rip-it-out-and-redo is fine.  Although it does help if
> you can tell us which of the review comments were and were not implemented,
> so we don't have to re-read the whole thing with the same level of
> attention.

Okay, I sent the whole set again.
I hope you have time to take a look :)


(didn't CC the patches for you because quilt sends them through my ISP
with @gmail.com => smpt.osdl.org would've not accepted them)

-- 
Anssi Hannula

