Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266834AbSKOWWi>; Fri, 15 Nov 2002 17:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266841AbSKOWWZ>; Fri, 15 Nov 2002 17:22:25 -0500
Received: from franka.aracnet.com ([216.99.193.44]:28868 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266834AbSKOWVe>; Fri, 15 Nov 2002 17:21:34 -0500
Date: Fri, 15 Nov 2002 14:25:43 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
Message-ID: <467361831.1037370342@[10.10.2.3]>
In-Reply-To: <p73of8qv6xi.fsf@oldwotan.suse.de>
References: <p73of8qv6xi.fsf@oldwotan.suse.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'm more concerned about the inevitable explosion of duplicates
>> and "fixed already"'s.
> 
> mozilla handles it this way: the bug starts as unconfirmed. they have a 
> volunteer group of pre screeners. Only when one of these people sets
> it to valid or similar then the owners of the module get mail.

Ours is set up the same way, it's just called "OPEN" state instead
of "UNCONFIRMED".
 
> I guess that could work for the linux kernel bugzilla too. Never hazzle
> a developer, until someone confirmed the bug in some way (this does not
> mean that he needs to reproduce it, just weed out obvious duplicates
> and bogus postings) 

Easy enough to do, we just need to change the default owners if 
people get overloaded.

M.

