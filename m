Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVFNVaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVFNVaC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 17:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVFNVaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 17:30:01 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:20867 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261347AbVFNV34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 17:29:56 -0400
Date: Tue, 14 Jun 2005 17:29:53 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Attempted summary of "RT patch acceptance" thread
In-reply-to: <200506141935.j5EJZtZ7024713@turing-police.cc.vt.edu>
To: linux-kernel@vger.kernel.org
Cc: Valdis.Kletnieks@vt.edu, Bill Huey (hui) <bhuey@lnxw.com>,
       Gerrit Huizenga <gh@us.ibm.com>, karim@opersys.com, dwalker@mvista.com,
       paulmck@us.ibm.com, Andrea Arcangeli <andrea@suse.de>,
       Lee Revell <rlrevell@joe-job.com>, Tim Bird <tim.bird@am.sony.com>,
       tglx@linutronix.de, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org
Message-id: <200506141729.54302.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <42AE0EF8.1090509@opersys.com>
 <20050614192056.GA2985@nietzsche.lynx.com>
 <200506141935.j5EJZtZ7024713@turing-police.cc.vt.edu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 June 2005 15:35, Valdis.Kletnieks@vt.edu wrote:
>On Tue, 14 Jun 2005 12:20:56 PDT, Bill Huey said:
>> This implications of this patch are huge. It's transparent and
>> will ultimately change the userspace land scape for just about
>> everything despite the paranoia and disinformation spread by
>> various arch-conservatives in this community.
>
>Is this patch running for political office? :)

That's entirely possible Valdis.  This patch has intrigued me for 
almost all the time that Ingo has been working on it, and I'm 
currently running 48-19.  Now he has converted a few others to both 
help and guide.  This cannot be anything but a plus for linux in the 
long view.  Unforch, I see, call it from the vantage point of an 
elder geek or whatever viewpoint, the digging in of heels and the 
speechifying against the changes proposed by those that in some sense 
consider themselves the 'guardian of the flame' or something.

I am somewhat reminded of Peter the Great, whose statement at the time 
was that he was going to bring Russia into the 20th century, kicking 
and screaming if neccessary.   I guess this is the kicking and 
screaming phase?

But, I also see this as a sign of health because I've read some pretty 
decent and very educational arguments here (I even half understood 
some of them!), with only minimal name-calling (I guess you all 
reserve that for JS maybe?) and have seen a few change their mind to 
become 'supporters of the cause'.

So lets all just keep on keeping on.  This WILL sort itself given 
enough time to get the application programmers onboard.  It is they 
who will find that they are the ones who need this, but they will 
also need to learn how to code to take advantage of it to its 
fullest.  For that, it needs a stable interface.  But its only going 
to become 'stable' by going mainline so it gets enough exposure and 
everything gets sorted eventually.

A sample app that needs help badly is kmail, any background processes 
involved with incoming mail sorting and filtering result in a frozen 
user interface for the duration of the background process.  So any 
kde people copying the mail here, sic 'em!  My guess is that this is 
exactly what you need to remove that particular user headache/itch.  
That's one of my personal itches...

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
