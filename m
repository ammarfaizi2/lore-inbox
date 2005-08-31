Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVHaTPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVHaTPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVHaTPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:15:43 -0400
Received: from [67.137.28.189] ([67.137.28.189]:52147 "EHLO vger")
	by vger.kernel.org with ESMTP id S932527AbVHaTPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:15:42 -0400
Message-ID: <4315F04D.5050705@soleranetworks.com>
Date: Wed, 31 Aug 2005 12:00:45 -0600
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Rik van Riel <riel@redhat.com>, linux <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
References: <4315DBE7.7080002@soleranetworks.com>	 <Pine.LNX.4.63.0508311432270.16968@cuia.boston.redhat.com>	 <4315E88D.9020603@soleranetworks.com> <1125514716.3213.24.camel@laptopd505.fenrus.org>
In-Reply-To: <1125514716.3213.24.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>The GPL terms that require GPL conversion of any code that runs on Linux 
>>is not supported by US Law. Many would
>>disagree, but that's OK. In short, it's just like any other proprietary 
>>app running on Linux. If it uses no Linux code (which
>>it does not), then the GPL does not apply to it .
>>    
>>
>
>except for section 2 which states that if parts are related (or at least
>not independent, for example when they are designed to exclusively work
>togethern), and one part is GPL, then both parts need to be, or you
>should not distribute the GPL part. This is not "your other code becomes
>gpl", it is "you can't distribute the GPL parts".
>  
>

The key word here is "designed to EXCLUSIVELY work together" as opposed to
"INCLUSIVE".  DSFS is not exclusive to Linux nor is it designed to run 
exclusively
on Linux.

 There's also a more fundamental problem with the GPL language.  The GPL 
stated it
confers "RIGHT TO COPY".  This is not the same as "RIGHT TO GRANT
LICENSES TO DISTRIBUTE."  Under US copyright law, if you confer to any 
person
the "right to copy" in a license which states the software is FREE, you 
have in essense
affected a copyright transfer to each and every person who receives the 
code. 
This is esspecially true since the GPL says that the software if "FREE". 

One could argue that the GPL requires reciprocal consdieration by requiring
conversion of ownsership of protected IP into a GPL licensing scheme, 
but this
violates several acts of Congress regarding anit-trust legislation.  
There is also
the argument of the doctrine of esstoppel.  This doctrine bascially says 
if you've
been using it for some period of time, and no one brings a claim, then 
it's become yours. 
Linux and GPL has also become an "essential facility" of the US 
Internet.  Under the Doctrine
of essential facility anything that by it's nature has become such an 
integrated part
of a class of activities affecting commerce, then the general public has 
a right to use it
without claims of IP infingement or licensing restrictions.

So, in short, the GPL language was and remains defective in this area.   
If someone takes
and uses GPL code which is claimed to be FREE, and runs proprietary 
applications on Linux,
particularly given Linus statements publically and those of others that 
Linux applications
are not affected, then those appplications, provided they use published 
interfaces, and
do not incorporate GPL code, are not subject to the GPL and it's terms.  
The modified
portions of Linux, are however, subject to the GPL, and they have been 
disclosed as required.

I do agree that the GPL has this language, but the balancing test in a 
Court of law would be whether
or not the program was designed to be "exclusively work together" based 
upon the plain language
of the license.

This is not the case here.  Folks may try to argue that the VFS 
interface in Linux is "exclusive", however,
it ais a public interface, just like an ethernet adapter is a public 
interface.  The real solution is to remove
the "right to copy" language from the GPL, and substitute, "right to 
grant sub-licenses to distribute", then
your arguments would be more solid in US District Court.

Jeff


>
>
>
>  
>

