Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262368AbTCMOxA>; Thu, 13 Mar 2003 09:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbTCMOw7>; Thu, 13 Mar 2003 09:52:59 -0500
Received: from mark.mielke.cc ([216.209.85.42]:58629 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S262368AbTCMOw6>;
	Thu, 13 Mar 2003 09:52:58 -0500
Date: Thu, 13 Mar 2003 10:10:47 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: James Stevenson <james@stev.org>, pd dd <parviz_kernel@yahoo.com>,
       "M. Soltysiak" <msoltysiak@hotmail.com>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: Re: Linux BUG: Memory Leak
Message-ID: <20030313151047.GA20516@mark.mielke.cc>
References: <01f901c2e96c$98b1e3d0$0cfea8c0@ezdsp.com> <Pine.LNX.3.95.1030313093618.21484A-100000@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1030313093618.21484A-100000@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 09:42:39AM -0500, Richard B. Johnson wrote:
> But it's a memory leak in the game, not the kernel. They should
> complain to the game makers. If a game runs the system out of
> memory so a user can't log in on the root account and kill off
> the game, it's a problem with the game.

I would like to encourage the camp of people who believe that UNIX can
be a stable server platform to innovate ways of ensuring that if a game
(or other memory intensive program) does run the system out of memory,
an administrator could login as root and kill the game.

So I don't agree with your conclusion. I think "your system crashed? well
contact the application designer..." is a mindset that was strongly
encoduraged by companies such as Microsoft, as it allowed them to release
half baked kernels and call them stable. Thankfully, even Microsoft has
learned that this isn't the best approach, and WinXP is quite a deal more
solid than Win95.

Yes, Linux is the result of (mostly) volunteer effort contributed to the
community. No, I don't think that means it is acceptable for it to contain
security exploits, or for it to be any less robust than other operating
systems in its class such as AIX or Solaris. We have smart people. Let's
use them. Let's not be satisfied with less.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

