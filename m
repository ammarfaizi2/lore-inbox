Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbVLGWYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbVLGWYP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbVLGWYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:24:15 -0500
Received: from Mail.MNSU.EDU ([134.29.1.12]:2512 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S1030397AbVLGWYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:24:13 -0500
Message-ID: <439760FF.3060605@mnsu.edu>
Date: Wed, 07 Dec 2005 16:23:59 -0600
From: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: Lee Revell <rlrevell@joe-job.com>, Dirk Steuwer <dirk@steuwer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Runs with Linux (tm)
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <20051205121851.GC2838@holomorphy.com> <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org> <loom.20051206T094816-40@post.gmane.org> <20051206104652.GB3354@favonius> <loom.20051206T173458-358@post.gmane.org> <20051207141720.GA533@kvack.org> <1133982741.17901.32.camel@mindpipe> <20051207194746.GG533@kvack.org>
In-Reply-To: <20051207194746.GG533@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

>On Wed, Dec 07, 2005 at 02:12:20PM -0500, Lee Revell wrote:
>  
>
>>If even some "Linux-friendly" hardware manufacturers barely cooperate
>>with the Linux comminuty now what makes you think this would work?
>>    
>>
>
>Nothing in life is guaranteed.  But at the very least, I think it would 
>be a good step towards improving the Linux end user experience.  Instead 
>of the unclear mess we have now (Is it supported?  Check with your 
>vendor!), we would be able to say "Look for the Linux Certified logo".  
>Combine that with a standard format for source code driver disks, and 
>it would be a good step in the right direction.
>
>  
>
The problem as I see it:

A hardware vendor hires someone to write a driver.  The driver is 
completed and submitted and finally makes it into the kernel.  It's 
fully GPL and everyone is happy.  The hardware gets a "Native Linux 
Support" logo.  The card goes out of favor and no one is interested in 
maintaining the driver, it is marked obsolete and finally removed from 
the kernel. ...the logo still suggests the hardware will work.

Possible fix:

It might be possible to add a serial number to the logo, and keep a 
database that maintains a current status of the device in the Linux kernel.

Does this make sense?

-- 
Jeffrey Hundstad
PS.  warning "not politically correct": When I heard "Native Linux 
Support" I immediately thought of Tux with a full Native American Indian 
headdress
