Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSKFOiE>; Wed, 6 Nov 2002 09:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265600AbSKFOiE>; Wed, 6 Nov 2002 09:38:04 -0500
Received: from smtp02.fields.gol.com ([203.216.5.132]:7911 "EHLO
	smtp02.fields.gol.com") by vger.kernel.org with ESMTP
	id <S265587AbSKFOiD>; Wed, 6 Nov 2002 09:38:03 -0500
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: yet another update to the post-halloween doc
In-Reply-To: <20021106140844.GA5463@suse.de>
References: <20021106140844.GA5463@suse.de>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
From: Miles Bader <miles@gnu.org>
Date: 06 Nov 2002 23:44:31 +0900
Message-ID: <87r8dylpv4.fsf@tc-1-100.kawasaki.gol.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Abuse-Complaints: abuse@gol.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> writes:
> Ports.
> ~~~~~~
> - 2.5 features support for several new architectures.
...
>   - uCLinux. 68k(w/o MMU) and v850 platforms.

A nit, I suppose, but the v850 is not a `platform' in the conventional
sense of the term, it's a completely new architecture.  uCLinux, OTOH,
is not an architecture, but a tweak to various parts of the kernel to
remove the requirement for an MMU (yeah I know what you meant, but
others may not).

Thanks,

-Miles
-- 
I have seen the enemy, and he is us.  -- Pogo
