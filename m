Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315079AbSDWGGm>; Tue, 23 Apr 2002 02:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315080AbSDWGGl>; Tue, 23 Apr 2002 02:06:41 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:9344 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S315079AbSDWGGk>; Tue, 23 Apr 2002 02:06:40 -0400
Date: Tue, 23 Apr 2002 07:04:17 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jeff Garzik <garzik@havoc.gtf.org>, Rasmus Andersen <rasmus@jaquet.dk>,
        CaT <cat@zip.com.au>, Larry McVoy <lm@bitmover.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020423070417.A19987@kushida.apsleyroad.org>
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yzWX-0000lZ-00@starship> <20020421143038.H8142@havoc.gtf.org> <E16z06w-0000mM-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> In fact, the basic premise is that people mail to the patchbot, not the
> maintainer.  The patchbot knows who the maintainer is and forwards the patch
> to the maintainer, using the maintainer's format of choice, or as now
> proposed, just drops it into the BK repository and forwards a notification,
> both to the maintainer and the linux-patches list.

Oh, now that _is_ a good idea.  So individuals like me can register and
say "notify me if anyone posts something for net/packet/* or
include/linux/if_packet.h".  Whether I'm a maintainer or not?

That would be pretty useful.

An uber-feature would be "notify me if the VFS interface or locking
rules change", for version 2 perhaps ;-)

-- Jamie
