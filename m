Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317567AbSGJRaU>; Wed, 10 Jul 2002 13:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317570AbSGJRaT>; Wed, 10 Jul 2002 13:30:19 -0400
Received: from mark.mielke.cc ([216.209.85.42]:43784 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S317567AbSGJRaP>;
	Wed, 10 Jul 2002 13:30:15 -0400
Date: Wed, 10 Jul 2002 13:26:26 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: jbradford@dial.pipex.com
Cc: Christian Ludwig <cl81@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: bzip2 patent status query
Message-ID: <20020710132626.A13654@mark.mielke.cc>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <200207101554.QAA07949@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207101554.QAA07949@darkstar.example.net>; from jbradford@dial.pipex.com on Wed, Jul 10, 2002 at 04:54:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 04:54:51PM +0100, jbradford@dial.pipex.com wrote:
> Is bzip2 *definitely* patent-unencumbered?
> It claims to be on it's home page, but I found this from the OpenBSD people:
> http://www.openbsd.org/2.8_packages/m68k/bzip-0.21.tgz-long.html

If you read a little further on the bzip pages, you would find that the
reason bzip2 and bzip are incompatible, is because bzip was found to be
patent-encumbered. The search for a better compression algorithm, that
wasn't covered by a patent began...

I actually remember when the original sources for the block sorter
compression program were posted to comp.sources.misc or somewhere
similar. The original impression most people had was 'this algorithm
is a hoax... it can't compress...' And so, I believe, nobody bothered
to patent it. :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

