Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUEYQmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUEYQmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 12:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264968AbUEYQme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 12:42:34 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:30888 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S264965AbUEYQmc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 12:42:32 -0400
Message-ID: <40B37795.6060207@timesys.com>
Date: Tue, 25 May 2004 12:43:01 -0400
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFD] Explicitly documenting patch submission
References: <Pine.LNX.4.58.0405222341380.18601@ppc970.osdl.org> <40B369D5.7070805@timesys.com> <Pine.LNX.4.58.0405250920510.9951@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405250920510.9951@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Tue, 25 May 2004, La Monte H.P. Yarroll wrote:
>  
>
>>Linus Torvalds wrote:
>>
>>    
>>
>>>The plan is to make this very light-weight, and to fit in with how we 
>>>already pass patches around - just add the sign-off to the end of the 
>>>explanation part of the patch. That sign-off would be just a single line 
>>>at the end (possibly after _other_ peoples sign-offs), saying:
>>>
>>>	Signed-off-by: Random J Developer <random@developer.org>
>>>      
>>>
>>To avoid the requirement of all submissions going through a single person,
>>we have a system of formal authorizations. Specific people are authorized
>>to release certain classes of work. Would the community object to a slight
>>modifications to the Signed-off-by lines from TimeSys? E.g.
>>
>>Signed-off-by: La Monte H.P. Yarroll <piggy@timesys.com> under TS00062
>>
>>This completes the traceability path all the way back to the VP who signed
>>off on TS00062.
>>    
>>
>
>I think this is great. In general, I think people who want to add their 
>own extra tags after their email address should be able to do so. We might 
>even have a few standard tags for things like asking for acknowledgement 
>etc.
>  
>
Thanks.

>>I THINK I have a case not covered here. I sometimes need to post
>>unpublished work done by other people at my company. Since the work is
>>not yet published, the GPL doesn't really grant me any special rights.
>>The authorization I use to publish is in fact NOT an open source
>>license. I think clause (b) could probably be weakened to cover my case.
>>    
>>
>
>I think the "(unless I am permitted to submit under a different license)" 
>part already covers that,  but yes, if we want to get really technically 
>anal about it we migth spell it out.
>  
>
It's an occupational hazzard for me--I talk to lawyers too much :-).  Let me
see if I can get a blessed recommendation for rephrasing clause (b).

I don't think the authorizations I work with qualify as licenses.

>>I'd like to include a link between the external path and our internal 
>>procedures.
>>    
>>
>
>Would the extra tag at the end be sufficient for that, or are you talking 
>about something more?
>  
>
The extra tag suffices.

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell's sig

