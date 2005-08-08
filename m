Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753171AbVHHBUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbVHHBUy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 21:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbVHHBUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 21:20:53 -0400
Received: from smtpout.mac.com ([17.250.248.89]:63477 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1753171AbVHHBUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 21:20:53 -0400
In-Reply-To: <200508080951.26433.kernel@kolivas.org>
References: <200508031559.24704.kernel@kolivas.org> <200508071512.22668.kernel@kolivas.org> <20050807165833.GA13918@in.ibm.com> <200508080951.26433.kernel@kolivas.org>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C845464B-FE91-4845-BE7A-3995B663396D@mac.com>
Cc: vatsa@in.ibm.com, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
Date: Sun, 7 Aug 2005 21:20:46 -0400
To: Con Kolivas <kernel@kolivas.org>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 7, 2005, at 19:51:25, Con Kolivas wrote:
> On Mon, 8 Aug 2005 02:58, Srivatsa Vaddagiri wrote:
>> Con,
>>     I am afraid until SMP correctness is resolved, then this is not
>> in a position to go in (unless you want to enable it only for UP,  
>> which
>> I think should not be our target). I am working on making this work
>> correctly on SMP systems. Hopefully I will post a patch soon.
>
> Great! I wasn't sure what time frame you meant when you last  
> posted. I won't
> do anything more, leaving this patch as it is, and pass the baton  
> to you.

I'm curious what has happened to the PPC side of the patch.  IIRC,  
someone
was working on such a port, but it seems to have been lost along the way
at some point.  Is there any additional information on that patch?

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that
would also stop them from doing clever things.
   -- Doug Gwyn


