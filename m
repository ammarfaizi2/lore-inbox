Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbUKBRF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbUKBRF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbUKBRBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:01:30 -0500
Received: from alog0507.analogic.com ([208.224.223.44]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261428AbUKBQyK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 11:54:10 -0500
Date: Tue, 2 Nov 2004 11:51:59 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linus Torvalds <torvalds@osdl.org>
cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Andreas Steinmetz <ast@domdv.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Richard Henderson <rth@redhat.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <Pine.LNX.4.58.0411020804410.2187@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0411021151250.4228@chaos.analogic.com>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org> 
 <417550FB.8020404@drdos.com>  <1098218286.8675.82.camel@mentorng.gurulabs.com>
  <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com> 
 <1098245904.23628.84.camel@krustophenia.net> <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
 <41826A7E.6020801@domdv.de> <Pine.LNX.4.61.0410291255400.17270@chaos.analogic.com>
 <Pine.LNX.4.58.0410291103000.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291424180.4870@chaos.analogic.com>
 <Pine.LNX.4.58.0410291209170.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410312024150.19538@chaos.analogic.com>
 <Pine.LNX.4.61.0411011219200.8483@twinlark.arctic.org>
 <Pine.LNX.4.61.0411011542430.24533@chaos.analogic.com>
 <Pine.LNX.4.58.0411011327400.28839@ppc970.osdl.org>
 <Pine.LNX.4.58.0411011342090.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0411020935010.3495@chaos.analogic.com>
 <Pine.LNX.4.58.0411020759040.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411020804410.2187@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004, Linus Torvalds wrote:

>
>
> On Tue, 2 Nov 2004, Linus Torvalds wrote:
>>
>> Just change the incorrect "3" in <asm-i386/linkage.h> (or whatever, this
>> is from memory) back to a "0"
>
> .. or just use the current -bk snapshot, actually. I may not have x86 as
> my main desktop, but it's not like I had a really hard time finding one
> (like the laptop laying there right on top of the desk ;), so the fixed
> version got checked in already.
>
> 		Linus

Okay. I got linux-2.6.9 back up.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
