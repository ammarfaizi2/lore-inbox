Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289699AbSA2QLH>; Tue, 29 Jan 2002 11:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289698AbSA2QK5>; Tue, 29 Jan 2002 11:10:57 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:35310 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286925AbSA2QKs>; Tue, 29 Jan 2002 11:10:48 -0500
Date: Tue, 29 Jan 2002 10:10:44 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <31420000.1012320644@baldur>
In-Reply-To: <E16VYD8-0003ta-00@the-village.bc.nu>
In-Reply-To: <E16VYD8-0003ta-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, January 29, 2002 13:22:05 +0000 Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:

> Lots of the stuff getting missed is tiny little fixes, obvious 3 or 4
> liners. The big stuff is not the problem most times. That stuff does get
> ripped to shreds and picked over as is needed. (Except device drivers,
> Linus alas has absolutely no taste in device drivers 8))
> 
> People collecting up patches _does_ help big time for all the small fixes.
> Especially ones disciplined enough to keep the originals they applied so
> they can feed stuff on with that tag. If I sent Linus on a patch that said
> "You've missed this fix by Andrew Morton" then Linus knew it was probably
> right for example.

I think this is a big part of the problem.  What's needed, and what Alan
used to provide, is a maintainer for the miscellaneous parts of the kernel
that aren't covered by the various subsystem maintainers.  We need someone
who can accept that one or two line fix, get it tested, and make sure Linus
sees it.

I gather Dave Jones is taking on that role to some extent.  If so, perhaps
he should be officially listed in the MAINTAINERS file.  Whether it's Dave
or someone else, I think this is a critical need.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

