Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTDPODk (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264385AbTDPODk 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:03:40 -0400
Received: from watch.techsource.com ([209.208.48.130]:20101 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S264379AbTDPODd 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:03:33 -0400
Message-ID: <3E9D688F.5040204@techsource.com>
Date: Wed, 16 Apr 2003 10:28:31 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerrit Huizenga <gh@us.ibm.com>
CC: John Bradford <john@grabjohn.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-English user messages
References: <E195cDL-00013K-00@w-gerrit2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Japanese are taught to read and write English as school children. 
 They also are taught how to write their own language in Romanji, which 
is an adaptation of the Roman alphabet.  How much you want to bet that 
the Japanese use English when they write error messages?  While I 
understand the spirit of your statement, despite its technical error, 
the spirit of my response is that you could replace "Japanese" with any 
other language and get the same effect.

Linus Torvalds isn't the first Finn I've encountered who speaks, reads, 
and writes English impeccably.

I've also never met a German who didn't speak English.

When we have Asian vendors from various countries come visit where I 
work, even the ones who need a translator speak English better than we 
speak their language.

The point of this painfully off-topic rant is that messages being 
written in English are a disadvantage for no one since they all already 
know English.  The messages are also simple enough that anyone 
intelligent enough to care what a Linux kernel message MEANS is probably 
intelligent enough to at least have an English-to-Whatever dictionary on 
hand.

I personally have a list of every kernel message I could extract from 
the source code of 2.4.20, and I've examined a lot of them.  It's a lot 
like reading Dr. Seuss.  Although some of the words are long, the 
vocabulary is incredibly small.  A lot of text is abbreviations and 
acronyms that you wouldn't translate anyhow!

This isn't an issue of fairness to people who speak other languages. 
 It's simply unnecessary and costs us far more than we gain.  One of the 
things I like about the Linux kernel is that people strive to "do the 
right thing", and it's improving all the time.  Internationalizing 
kernel messages, that shouldn't appear anyhow if we did our jobs right, 
would NOT be an improvement.

Mind you, I like to try to be open-minded.  Based on my own reasoning, I 
see this as being unnecessary, but I can be convinced otherwise.  You're 
just going to have to come up with a much better reason than what has 
been offered by yourself and others in this thread.


Gerrit Huizenga wrote:

>On Fri, 11 Apr 2003 14:40:55 BST, John Bradford wrote:
>  
>
>>Well, you don't need error codes to make a comprehensive manual, you
>>can just look up the English error message, and get a detailed
>>explaination of it, in any language.
>>    
>>
>
>Can someone hand that man a japanese error message and ask him to
>look it up in a japanese dictionary?
>
>Walk for a moment in the other language's shoes...
>
>Mixing metaphores as time flies....
>
>gerrit
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>


