Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264131AbUFKQhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUFKQhX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUFKQfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:35:03 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:57239 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264223AbUFKQba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:31:30 -0400
Message-ID: <40C9DE9F.90901@namesys.com>
Date: Fri, 11 Jun 2004 09:32:31 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Dave Jones <davej@redhat.com>, Chris Mason <mason@suse.com>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com> <20040609182037.GA12771@redhat.com> <40C79FE2.4040802@namesys.com> <20040610223532.GB3340@wohnheim.fh-wedel.de> <40C91DA0.6060705@namesys.com> <20040611134621.GA3633@wohnheim.fh-wedel.de>
In-Reply-To: <20040611134621.GA3633@wohnheim.fh-wedel.de>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>On Thu, 10 June 2004 19:49:04 -0700, Hans Reiser wrote:
>  
>
>>Jörn Engel wrote:
>>
>>    
>>
>>>It appears to me that most developers agree to the two point above,
>>>but you have some problems with them, at least lately.  Am i wrong?
>>>      
>>>
>>This is all part of what responsible release management is about.   I 
>>was the junior whiz kid in professional release management teams before 
>>starting Namesys.  I listened to my elders and learned from them.  My 
>>standards for professional conduct in this arena are higher than yours 
>>as a result of that. 
>>
>>You are a bunch of young kids who lack professional experience in 
>>release management.  That is ok, but don't get aggressive about it.
>>
>>I have no desire to pay for your mistakes, and as the official 
>>maintainer it is my responsibility to ensure that neither I nor the 
>>users pay for the mistakes of those who add bugs to stable branches 
>>instead of adding them to the development branches where they belong.
>>    
>>
>
>Well, this ain't OpenBSD.  They have a strict 6month release schedule,
>so your type of development works just fine for them.  Linux has
>something like a very relaxed 24month+ release "schedule", which is
>far too long for some people.  As a result, the Linux "stable" kernel
>is a lot less stable than the OpenBSD one.
>
>But long release cycles also have their advantages and - most
>important - they work with Linus.  So effectively, we all have to
>accept them and deal with the consequenses.  I really understand and
>partially share your doubts, but what does it help? ;)
>
>Jörn
>
>  
>
Reiser4 is going to obsolete V3 in a few weeks.  V3 will be retained for 
compatibility reasons only, as V4 blows it away in performance.

You are right though that OpenBSD does some things better.

Hans
