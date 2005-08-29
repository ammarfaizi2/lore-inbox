Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVH2O0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVH2O0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 10:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVH2O0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 10:26:05 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:40549 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750737AbVH2O0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 10:26:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=msmKMlJTgkOQmhSHFpWKOb7L830RB+5uVfy5vyO3v+Mmr1iDxy/ggLyEWmwWhOcGO6BYBc8VbiU7huIL2tVolvqOJb2hP9oFHt1IEXZ4hn9tm8sIBQIhHxwErxneAi3VKQKYRIwn6+SLUUNWbFMQMvYsrv5kilr2WiJmlAcLDFE=
Message-ID: <43131AE9.7010802@gmail.com>
Date: Mon, 29 Aug 2005 22:25:45 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com
CC: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13
References: <Pine.LNX.4.58.0508281708040.3243@g5.osdl.org>	 <1125313050.5611.11.camel@localhost.localdomain> <1125317850.6496.7.camel@localhost>
In-Reply-To: <1125317850.6496.7.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2005-08-29 at 20:57, Steven Rostedt wrote:
>> On Sun, 2005-08-28 at 17:17 -0700, Linus Torvalds wrote:
>>
>>> Paul Mackerras:
>>>   Remove race between con_open and con_close
>> Hey, I'm the first to report this with the fix and Paul gets the credit?
>> I guess I'll crawl back to my little world (RT) where they actually
>> appreciate me. :-(
> 
> Did you report it or fix it? :>
> 

Both, actually, with exactly the same patch.  In the long changelog, both 
Steven and Paul are co-signees but only Paul's name appeared in the short 
changelog.

Tony
