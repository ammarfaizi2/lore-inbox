Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbSKSDjd>; Mon, 18 Nov 2002 22:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbSKSDjc>; Mon, 18 Nov 2002 22:39:32 -0500
Received: from findaloan-online.cc ([216.209.85.42]:21775 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265171AbSKSDjb>;
	Mon, 18 Nov 2002 22:39:31 -0500
Date: Mon, 18 Nov 2002 22:53:45 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Dan Kegel <dank@kegel.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021119035345.GA16798@mark.mielke.cc>
References: <Pine.LNX.4.44.0211181520140.979-100000@blue1.dev.mcafeelabs.com> <3DD97D4D.3010801@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD97D4D.3010801@kegel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 03:52:45PM -0800, Dan Kegel wrote:
> I'm not so sure.  If the epoll documentation were clear enough
> (which at the moment, frankly, it isn't), I think
> there's a good chance users would not be confused
> by the difference between level-triggered and edge-triggered
> events.

I would argue that it is a good thing that people that believe poll and
epoll to be almost exactly the same, find themselves confused.

I might not succeed, but it is certainly how I feel about the issue.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

