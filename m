Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVJEFtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVJEFtJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 01:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVJEFtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 01:49:09 -0400
Received: from 10.ctyme.com ([69.50.231.10]:16336 "EHLO newton.ctyme.com")
	by vger.kernel.org with ESMTP id S932546AbVJEFtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 01:49:08 -0400
Message-ID: <4343694F.5000709@perkel.com>
Date: Tue, 04 Oct 2005 22:49:03 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "D. Hazelton" <dhazelton@enter.net>
CC: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <200510050122.39307.dhazelton@enter.net>
In-Reply-To: <200510050122.39307.dhazelton@enter.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: newton.ctyme.com - http://www.junkemailfilter.com"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



D. Hazelton wrote:

>  
>
>>Novell Netware type permissions. ACLs are a step in the right
>>direction but Linux isn't any where near where Novell was back in
>>1990. Linux lets you - for example - to delete files that you have
>>no read or write access rights to. 
>>    
>>
>
>As someone else pointed out, this is because unlinking is related to 
>your access permissions on the parent directory and not the file.
>
>  
>
Right - that's Unix "inside the box" thinking. The idea is to make the 
operating system smarter so that the user doesn't have to deal with 
what's computer friendly - but reather what makes sense to the user. 
 From a user's perspective if you have not rights to access a file then 
why should you be allowed to delete it?

Now - the idea is to create choice. If you need to emulate Unix nehavior 
for compatibility that's fine. But I would migrate away from that into a 
permissions paradygme that worked like Netware.

I started with Netware and I'm spoiled. They had it right 15 years ago 
and Linux isn't any where near what I was with Netware and DOS in 1990. 
Once you've had this kind of permission power Linux is a real big step down.

So - the thread is about the future so I say - time to fix Unix.


