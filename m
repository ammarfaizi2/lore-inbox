Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVL1AFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVL1AFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 19:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVL1AFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 19:05:42 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:3760 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S932407AbVL1AFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 19:05:41 -0500
Message-ID: <43B1D6C6.30300@metaparadigm.com>
Date: Wed, 28 Dec 2005 08:05:26 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Steven Rostedt <rostedt@goodmis.org>, Jaco Kroon <jaco@kroon.co.za>,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume
 support (try 2)
References: <43AF7724.8090302@kroon.co.za>	 <200512261535.09307.s0348365@sms.ed.ac.uk>	 <1135619641.8293.50.camel@mindpipe>	 <200512262003.38552.s0348365@sms.ed.ac.uk> <1135630831.8293.89.camel@mindpipe>
In-Reply-To: <1135630831.8293.89.camel@mindpipe>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Mon, 2005-12-26 at 20:03 +0000, Alistair John Strachan wrote:
>  
>
>>On Monday 26 December 2005 17:54, Lee Revell wrote:
>>    
>>
>>>On Mon, 2005-12-26 at 15:35 +0000, Alistair John Strachan wrote:
>>>      
>>>
>>>>On Monday 26 December 2005 14:38, Steven Rostedt wrote:
>>>>        
>>>>
>>[snip]
>>    
>>
>>>>>I use pine and evolution.  Pine is text based and great when I ssh into
>>>>>my machine to work.  Evolution is slow, but plays well with pine and it
>>>>>handles things needed for LKML very well. (the drop down menu "Normal"
>>>>>may be changed to "Preformat", which allows of inserting text files
>>>>>"as-is").
>>>>>          
>>>>>
This is also the way to do it with Thunderbird. It will do the right
thing (and disables all formatting changes such as line wrapping to the
inserted text) if you select 'Preformat' before pasting in a patch - at
least my Thunderbird 1.0.7 does this.

>>>>Dare I say it, KMail has also been doing the Right Thing for a long time.
>>>>It will only line wrap things that you insert by typing; pastes are left
>>>>untouched.
>>>>        
>>>>
>>>It seems that of all the popular mail clients only Thunderbird has this
>>>problem.  AFAICT it's impossible to make it DTRT with inline patches and
>>>even if it is the fact that most users get it wrong points to a serious
>>>usability/UI issue.
>>>
>>>Would a patch to add "Don't use Thunderbird/Mozilla Mail" to
>>>SubmittingPatches be accepted?  Then we can point the Mozilla developers
>>>at it (they have shown zero interest in fixing the problem so far) and
>>>hopefully this will light a fire under someone.
>>>      
>>>
>>Fundamentally the issue with Thunderbird is that it line-wraps AFTER you 
>>compose an email, not during composition. I've never understood how, or why 
>>this is useful to the end user, except for composing HTML emails (which 
>>should be banned anyway).
>>    
>>
Thunderbird will not linewrap anything that is inserted in 'Preformat' mode.

>>Thunderbird is Yet Another mailer that could have been a good piece of 
>>software if it hadn't attempted to be a clone of Outlook Express (defaulting 
>>to Top Posting, HTML composition, line wrapping pastes).
>>
>>It's the mindset; fixing Thunderbird is probably easy, but convincing the 
>>Mozilla developers to include such "fixes" is probably much harder.
>>
>>    
>>
>
>Should be trivial to fix, when the user puts the editor into "Preformat"
>mode or inserts a text file you surround it with <pre> tags.
>  
>
Fix the user behaviour you mean? Get them to select 'Preformat' before
pasting patches into Thunderbird.

~mc
