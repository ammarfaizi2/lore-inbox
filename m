Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932575AbWBXE3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbWBXE3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 23:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWBXE3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 23:29:09 -0500
Received: from smtpauth01.mail.atl.earthlink.net ([209.86.89.61]:7109 "EHLO
	smtpauth01.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S932575AbWBXE3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 23:29:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=hBsjUCOXq4VLkXkvXCZsMFa2PsvzxT790mxOC5F3zH62c5/KzTATgZNrdAho1s9m;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <0d3f01c638fa$d84c0d00$0225a8c0@oddball>
From: "jdow" <jdow@earthlink.net>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       "Arjan van de Ven" <arjan@infradead.org>
Cc: "Nick Warne" <nick@linicks.net>, "Chris Adams" <cmadams@hiwaay.net>,
       <linux-kernel@vger.kernel.org>
References: <43FCFDC6.9090109@soleranetworks.com>	 <20060223145920.GA1311407@hiwaay.net>	 <7c3341450602230831m1265e49g@mail.gmail.com>	 <1140713030.4672.75.camel@laptopd505.fenrus.org>	 <43FDFBDE.2040304@wolfmountaingroup.com> <1140716828.4672.80.camel@laptopd505.fenrus.org> <43FE02DA.90003@wolfmountaingroup.com>
Subject: Re: Red Hat ES4 GPL Issues?
Date: Thu, 23 Feb 2006 20:29:03 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2670
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b5711209e98e519931389bee75c633aa29c2d91674d26ee3fc7409a350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.164.67
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>

> Arjan van de Ven wrote:
> 
>>On Thu, 2006-02-23 at 11:15 -0700, Jeff V. Merkey wrote:
>>  
>>
>>>Arjan van de Ven wrote:
>>>
>>>    
>>>
>>>>>But anyway, what has this thread to do with the kernel?
>>>>>   
>>>>>
>>>>>        
>>>>>
>>>>since when does something need to be on-topic for Jeff Merkey to post to
>>>>lkml ? ;-)
>>>>
>>>> 
>>>>
>>>>      
>>>>
>>>I got the RPM's and located them from an earlier responder to the post.  
>>>It was just disturbing
>>>that RedHat does ont include the sources when you install from binary -- 
>>>which they always have
>>>before. 
>>>
>>>    
>>>
>>
>>you forgot to download the cd images labeled "source".
>>What's the problem???
>>  
>>
> I did not download them, procuement here did and they did not grab the 
> SRPMS iso's

So they screwed up. That is not RedHat's fault. This is the way they
have always made a distribution since source and binary outgrew a single
disk. Binary's on one disk and Sources on another. Eventually it became
binaries on several disks and sources on several other disks.

>>>I am glad Red Hat is still distributing the code, but I am disappointed 
>>>they are no longer
>>>including it in the base RPM install.
>>>    
>>>
>>
>>oh you don't mean the src.rpm but the full kernel source code installed?
>>That's explained in the release notes; it's 2 shell commands to create
>>it, and it's in a way silly to make an exception for the kernel here
>>compared to all other software. And CD real estate on the binary cd's is
>>scarse as well. 
>>
>>
>>
>>  
>>
> I know but this deviates from how they did it in the past.  No worry, 
> sooner or later Linux will get so
> large in these distros, you will need a DVD to hold all of it, so I can 
> understand if space was at a premium
> on those CD iso images.

When's the last time you did a RedHat install?

{^_^}   Joanne
