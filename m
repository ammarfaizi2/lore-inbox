Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbSJCVSN>; Thu, 3 Oct 2002 17:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSJCVSN>; Thu, 3 Oct 2002 17:18:13 -0400
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.232.94]:2564
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261258AbSJCVSM>; Thu, 3 Oct 2002 17:18:12 -0400
Date: Thu, 3 Oct 2002 17:26:05 -0400 (EDT)
From: Shawn Starr <spstarr@sh0n.net>
To: Joe Kellner <jdk@kingsmeadefarm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: XFS and 2.4.19
In-Reply-To: <1033679763.3d9cb3939f610@webmail>
Message-ID: <Pine.LNX.4.44.0210031722380.11195-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rmap is the newer VM that Rik van Riel and William Lee Irwin III and
others have worked on. Rmap (most of it) is in the 2.5 development kernel.

It speeds up XFS's preformance greatly from the tests I've done.

Shawn.

On Thu, 3 Oct 2002, Joe Kellner wrote:

> I've been slacking on my following of things lately..What exactly is rmap? is it
> related to XFS?
>
> Thanks,
> -Joe
>
>
>
>
>
>
>
> Quoting Shawn Starr <spstarr@sh0n.net>:
>
> > You could try my patchse which contains XFS-CVS and rmap support.
> >
> > you can get them at http://xfs.sh0n.net/2.4/stable
> >
> > (site is currently down).
> >
> >
> >
>
>
>
>
> -------------------------------------------------
> sent via KingsMeade secure webmail http://www.kingsmeadefarm.com
>
>

--
Shawn Starr, sh0n.net, <spstarr@sh0n.net>
Maintainer: -shawn kernel patches: http://xfs.sh0n.net/2.4/

