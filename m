Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293301AbSB1OZl>; Thu, 28 Feb 2002 09:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292958AbSB1OXG>; Thu, 28 Feb 2002 09:23:06 -0500
Received: from [195.63.194.11] ([195.63.194.11]:62475 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293410AbSB1OUQ>; Thu, 28 Feb 2002 09:20:16 -0500
Message-ID: <3C7E3C71.6050604@evision-ventures.com>
Date: Thu, 28 Feb 2002 15:19:29 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: [PATCH] IDE clean 12 3rd attempt
In-Reply-To: <UTC200202241352.g1ODqeb08003.aeb@apps.cwi.nl> <3C79435E.8030208@evision-ventures.com> <20020228094444.GB750@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I sure hope they do.
> 
> I run 2.4.x on 486sx, which is .... pretty close to 386. 386 support
> is not going to get dropped anytime soon...

Well the 486sx is the same die as 486 with coproc disabled. And in
contrast the the 386 the 486 is a scalar, tough not super-scalar CPU.
(This is what this "pipline stuff" and multiple pipeline stuff is about ;-).

Please trust me they are *not* very similar from CPU design point
of view. They are only similar on the command set level.
Anyway just to put it straight: Your system certainly won't be affected
by the removal.

