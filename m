Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290480AbSAQVsb>; Thu, 17 Jan 2002 16:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290484AbSAQVsU>; Thu, 17 Jan 2002 16:48:20 -0500
Received: from 213-96-124-18.uc.nombres.ttd.es ([213.96.124.18]:14575 "HELO
	dardhal") by vger.kernel.org with SMTP id <S290480AbSAQVsB>;
	Thu, 17 Jan 2002 16:48:01 -0500
Date: Thu, 17 Jan 2002 22:47:53 +0100
From: Jose Luis Domingo Lopez <jdomingo@internautas.org>
To: Guillaume Boissiere <boissiere@mediaone.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 17, 2001
Message-ID: <20020117214752.GA5085@localhost>
Mail-Followup-To: Guillaume Boissiere <boissiere@mediaone.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C463337.24593.CD1AD57@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3C463337.24593.CD1AD57@localhost>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 17 January 2002, at 02:13:11 -0500,
Guillaume Boissiere wrote:

> I've seen several times on this list people wondering what features
> were in the works for 2.5 and what the status of the development was.
> I did some grepping on the archive and put together a list of things 
> that have been discussed / worked on for 2.5 over the past year or so.  
> 
Great !!!. I think this "todo list" was much needed. Let me suggest a
couple of things that should find their way into 2.5.x sometime in the
futute, and that I consider important:
. Generic (VFS layer?) ACL implementation: it seems under heavy
  develpment by some groups, and could be something quite interesting to
  have for 2.6.x
. Linux Security Module (LSM)
. LVM 2: it seems LVM developers are about to release a first version of
  the new (version 2.0) LVM (Logical Volume Management) implementation
  for Linux. Seems to solve the problems current code base has.
. devfs 2: new implementation of Richard Gooch's devfs for Linux. devfs
  is a "must have" for some people, and this new code seems to solve
  everything that people complained about. AFAIR, Richard has submitted
  several "cuts" of the new code.

There are other interesting things I don't follow as closely, and that
could be available when 2.5.x is still under development, maybe not.
. reiserfs 4 (later this year): maybe too late for inclusion.
. USAGI IPv6 implementation for Linux: maybe not ready for prime time.
. NFS v4: have read about it, but don't remember about deadlines.
. IPsec in kernel (FreeS/WAN): the neverending story :)

That is what I think are the most important things that _could_ be part
of future 2.6.0, should maintainers consider it as a good idea. Please,
this is only informative, not trying to "sell" you nothing.

Good work !

-- 
José Luis Domingo López
Linux Registered User #189436     Debian Linux Woody (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

