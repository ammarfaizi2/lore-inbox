Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSGMNuU>; Sat, 13 Jul 2002 09:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSGMNuT>; Sat, 13 Jul 2002 09:50:19 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:9225 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S313477AbSGMNuR>; Sat, 13 Jul 2002 09:50:17 -0400
Date: Sat, 13 Jul 2002 23:56:02 +1000
From: john slee <indigoid@higherplane.net>
To: Daniel Phillips <phillips@arcor.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bzip2 support against 2.4.18
Message-ID: <20020713135602.GK7579@higherplane.net>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <E17SheA-0002Uh-00@starship> <000901c2296e$7cab2ed0$1c6fa8c0@hyper> <E17Suso-0002dn-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17Suso-0002dn-00@starship>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 09:30:29AM +0200, Daniel Phillips wrote:
> Actually, what is the use of even including 'bz2' in the name?  Nobody
> besides we geeks needs to know the thing is compressed with bzip2.  It
> would be nice to see the word 'linux' in there.  How about bzlinux?
> Just think of the hundreds of cases of carpal tunnel syndrome you'd
> prevent by eliminating the shifted character.

why not just call it 'linux'?  file(1) exists for a reason, and the 'vm'
prefix is a bit redundant these days

also i've never really understood why the binary format of the kernel is
selected via make.  why not just make it a regular kernel option with a
sane default?  surely your average kernel compiling person picks
something that works (zImage? bzImage? Image?) and sticks to it...

j.

-- 
toyota power: http://indigoid.net/
