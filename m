Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVBCIdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVBCIdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 03:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVBCIdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 03:33:22 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:18191 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262596AbVBCIby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 03:31:54 -0500
Message-ID: <4201E388.5050501@hist.no>
Date: Thu, 03 Feb 2005 09:40:40 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Charles Cazabon <linux@discworld.dyndns.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Copyright / licensing question
References: <20050202144915.94462.qmail@web42106.mail.yahoo.com> <1107385864.21196.632.camel@tglx.tec.linutronix.de> <20050202232725.GA6197@discworld.dyndns.org>
In-Reply-To: <20050202232725.GA6197@discworld.dyndns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Cazabon wrote:

>Thomas Gleixner <tglx@linutronix.de> wrote:
>  
>
>>On Wed, 2005-02-02 at 06:49 -0800, Frank klein wrote:
>>    
>>
>>>I am having some licensing questions. It would be
>>>really great if you can clarify on them
>>>
>>>1. For explaining the internals of a filesystem in
>>>detail, I need to take their code from kernel sources
>>>'as it is' in the book. Do I need to take any
>>>permissions from the owner/maintainer regarding this ?
>>>Will it violate any license if reproduce the driver
>>>source code in my book ??
>>>      
>>>
>>Legally, not if you mention the licence of the code clearly. 
>>    
>>
>
>I'm not sure that's the case.  Inclusion of significant chunks of source code
>(not just a dozen lines or whatever) might bring the book into "derived work"
>territory, and your publisher is almost certainly not going to allow
>redistribution under the GPL ...
>  
>
I don't think this will be a problem.  The separation between code
and the rest of the book is clear, and the book isn't directly 
executable. :-)

Even a book that mainly list source and merely offer some short explanations
should be easy to get right - the _code_ is GPL so it is okay for people to
photocopy it off the pages (who in their right mind would, though) but
the rest of the book is printed under ordinary terms.

Helge Hafting
