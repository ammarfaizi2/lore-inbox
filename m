Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUBREIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbUBREHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:07:51 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:23509
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S263088AbUBREHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:07:10 -0500
Message-ID: <4032E0A6.7060608@tmr.com>
Date: Tue, 17 Feb 2004 22:48:54 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Robert White <rwhite@casabyte.com>, "'Theodore Ts'o'" <tytso@mit.edu>,
       "'Pavel Machek'" <pavel@ucw.cz>, "'the grugq'" <grugq@hcunix.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH - ext2fs privacy (i.e. secure deletion) patch
References: <20040204062936.GA2663@thunk.org> <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAiYFsPtMTN0OBYHMfkO9ONQEAAAAA@casabyte.com> <20040213034119.GK25499@mail.shareable.org>
In-Reply-To: <20040213034119.GK25499@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Robert White wrote:
> 
>>On the more positive side this would be _*outstanding*_ for my NV-RAM
>>keychain drive where the files are warranted to be small and I don't want
>>some random person who finds my lost keychain even able to guess about that
>>pesky project I was working on last month.
> 
> 
> An encrypted and/or steganographic filesystem would be much better for
> your NVRAM keychain drive, because that hides your files even when you
> _haven't_ deleted them.

But these are not mutually exclusive. Even if the data are encrypted, 
when I delete something I want it GONE. That way even if a TLA with 
resources to break the crypto steals my device, my previous password 
list is safe.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
