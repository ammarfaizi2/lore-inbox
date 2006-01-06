Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWAFVqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWAFVqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWAFVqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:46:44 -0500
Received: from smtpout.mac.com ([17.250.248.71]:4311 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751369AbWAFVqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:46:43 -0500
In-Reply-To: <20060106213950.GA26581@csclub.uwaterloo.ca>
References: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com> <20060106213950.GA26581@csclub.uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ED6587C7-CBE3-446E-AB32-609E18A22342@mac.com>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if unsure, say N"
Date: Fri, 6 Jan 2006 16:46:37 -0500
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 06, 2006, at 16:39, Lennart Sorensen wrote:
> On Fri, Jan 06, 2006 at 10:10:13PM +0100, Alessandro Suardi wrote:
>> ===========
>> Userspace-driven configuration filesystem (EXPERIMENTAL)  
>> (CONFIGFS_FS)
>> [M/y/?] (NEW)
>>
>> Both sysfs and configfs can and should exist together on the same  
>> system. One is not a replacement for the other.
>>
>> If unsure, say N.
>> ===========
>>
>> I think I'll say M - for now ;)
>
> Sure, if you want to play with configfs you should.  Most users  
> probably have no interest in helping develop/debug it, so the  
> decomendation makes perfect sense.

I think his point is that his options are [M/y/?], (IE: No N), which  
means that he's using something that depends on configfs.  The  
documentation should probably be updated to indicate that there are  
such things.

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



