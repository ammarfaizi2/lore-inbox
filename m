Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262481AbSJEToK>; Sat, 5 Oct 2002 15:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262484AbSJEToK>; Sat, 5 Oct 2002 15:44:10 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:62103 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262481AbSJEToI>;
	Sat, 5 Oct 2002 15:44:08 -0400
Message-ID: <3D9F4255.3060600@candelatech.com>
Date: Sat, 05 Oct 2002 12:49:41 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gigi Duru <giduru@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
References: <20021005193650.17795.qmail@web13202.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gigi Duru wrote:
> Trivial experiment: configure out _ALL_ the options on
> 2.5.38 and build bzImage. My result? A totally useless
> 270KB kernel (compressed). 

Maybe you could explain the options you had to add to make
it useful to you?  That may help folks figure out where the
thing can be slimmed down.

> Now try to put in some useful stuff and the
> _compressed_ image will cheerfully approach 1MB. Where
> are the days when a 200KB kernel would be fully
> equipped?

Gone too are the days where you could easily buy something
as small as a 2MB flash chip :)

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


