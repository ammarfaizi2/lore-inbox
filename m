Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310194AbSCKQiB>; Mon, 11 Mar 2002 11:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310197AbSCKQho>; Mon, 11 Mar 2002 11:37:44 -0500
Received: from [195.63.194.11] ([195.63.194.11]:64521 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310194AbSCKQh3>; Mon, 11 Mar 2002 11:37:29 -0500
Message-ID: <3C8CDD02.3060907@evision-ventures.com>
Date: Mon, 11 Mar 2002 17:36:18 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Martin Dalecki <martin@dalecki.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <20020311161334.A1513@ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> Hi!
> 
> This patch replaces the current AMD IDE driver (by Andre Hedrick) by
> mine. Myself I think my implementation is much cleaner, but I'll leave
> upon others to judge that. My driver also additionally supports the
> AMD-8111 IDE.
> 
> It's well tested, and I'd like to have this in the kernel instead of
> what's there now.

Agreed. Let's give it a try. (This is trivial to back up.)

