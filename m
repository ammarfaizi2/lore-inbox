Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264517AbTDPSIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbTDPSIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:08:30 -0400
Received: from watch.techsource.com ([209.208.48.130]:667 "EHLO techsource.com")
	by vger.kernel.org with ESMTP id S264517AbTDPSI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:08:27 -0400
Message-ID: <3E9DA244.2030108@techsource.com>
Date: Wed, 16 Apr 2003 14:34:44 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bruce Harada <bharada@coral.ocn.ne.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-English user messages
References: <E195cDL-00013K-00@w-gerrit2>	<3E9D688F.5040204@techsource.com> <20030417020413.49af6390.bharada@coral.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bruce Harada wrote:

>Suggestion: Chop your CCs. I sus pect Linus gave up on this topic a long time
>ago, as (most likely) have the majority of the others.
>
>On Wed, 16 Apr 2003 10:28:31 -0400
>Timothy Miller <miller@techsource.com> wrote:
>
>  
>
>>The Japanese are taught to read and write English as school children. 
>> They also are taught how to write their own language in Romanji, which 
>>is an adaptation of the Roman alphabet.
>>    
>>
>
>No, they're not (taught to write Japanese in Romaji, that is).
>  
>
Perhaps I was mistaken on that.

>  
>
>> How much you want to bet that 
>>the Japanese use English when they write error messages?
>>    
>>
>
>Well, it rather depends on the person... try setting your locale to
>ja_JP.eucJP, and you might be surprised by the applications that give you
>Japanese messages. Certainly, some Japanese people prefer messages in
>English, but that can hardly be generalized across the entire userbase.
>  
>
Applications.  Far more people work on applications than on the kernel.

I'm not saying I don't think Japanese would benefit from Japanese 
messages.  I'm saying that, in my humble estimation, i18n kernel 
messages would lose in the cost-benefit analysis.

>  
>
>>Linus Torvalds isn't the first Finn I've encountered who speaks, reads, 
>>and writes English impeccably.
>>
>>I've also never met a German who didn't speak English.
>>
>>When we have Asian vendors from various countries come visit where I 
>>work, even the ones who need a translator speak English better than we 
>>speak their language.
>>    
>>
>
>My only answer is, you have only had the opportunity to meet people from
>overseas who have some English ability... really, your argument is on the same
>level as "I've got lots of foreign friends who all like <whatever>, so all
>foreigners must like <whatever>."
>
You make a good point.

>
>Bruce
>
>
>PS: I'm against translating kernel messages, but for technical reasons (simple
>== good) rather than some wild idea that everybody else in the world can
>understand English.
>
I agree that an objective technical analysis, not personal opinion, 
should be the basis of our decision on this matter.



