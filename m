Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbTABF6P>; Thu, 2 Jan 2003 00:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbTABF6O>; Thu, 2 Jan 2003 00:58:14 -0500
Received: from auto-matic.ca ([216.209.85.42]:35343 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265705AbTABF6I>;
	Thu, 2 Jan 2003 00:58:08 -0500
Date: Thu, 2 Jan 2003 01:14:30 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Paul Jakma <paul@clubi.ie>, Rik van Riel <riel@conectiva.com.br>,
       Hell.Surfers@cwctv.net, linux-kernel@vger.kernel.org, rms@gnu.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
Message-ID: <20030102061430.GA23276@mark.mielke.cc>
References: <20030102013736.GA2708@gnuppy.monkey.org> <Pine.LNX.4.44.0301020245080.8691-100000@fogarty.jakma.org> <20030102055859.GA3991@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102055859.GA3991@gnuppy.monkey.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GPL aside (it could be argued forever...):

I regularly use several kernel modules that provide a GPL component that
interfaces the module to the kernel, and a closed source object file that
is dynamically loaded as a kernel module at run time.

If I did not have these modules, I would not be able to use Linux as my
host operating system.

So... to those (Hell.Surfers especially it seems) who believe that they
are doing good by making a scene... realize that while you may succeed
in improving the integrity of the GPL, you will also succeed in convincing
companies that it may be more expensive than it is worth to provide their
hardware or software for Linux. That may mean that I will be forced to
stop using Linux at work, and possibly forced to stop using Linux at home.

Perhaps I am a minority. Are you willing to bet the future of Linux on it?

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

