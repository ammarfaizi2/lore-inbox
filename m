Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264087AbTGGAs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 20:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbTGGAs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 20:48:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:56296 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264087AbTGGAsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 20:48:25 -0400
Date: Sun, 6 Jul 2003 22:00:34 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre3
In-Reply-To: <20030706134156.GG502@phunnypharm.org>
Message-ID: <Pine.LNX.4.55L.0307062157300.30827@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
 <20030706134156.GG502@phunnypharm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jul 2003, Ben Collins wrote:

> On Sat, Jul 05, 2003 at 10:02:09PM -0300, Marcelo Tosatti wrote:
> >
> > Hi,
> >
> > Here goes -pre3. It contains a lot of updates and fixes all over.
>
> Any chance you could be consistent in tagging the -pre's? Neither pre2,
> nor pre3 is tagged in BK, and thus, not tagged in CVS/SVN either.

I guess I have tagged -pre2 and -pre3:

ChangeSet@1.1024, 2003-07-05 20:59:23-03:00, mason@suse.com
  [PATCH] Fix potential IO hangs and increase interactiveness during heavy
IO

  io-stalls-10:


  ===== drivers/block/ll_rw_blk.c 1.45 vs edited =====
  TAG: v2.4.22-pre3


-----

ChangeSet@1.1011, 2003-06-26 18:25:43-03:00, trini@kernel.crashing.org
  [PATCH] Add /proc/sys/kernel/l3cr

  Hello.  The following patch is from Mark Greer.  This adds read-only
  support for the L3 cache register found in the MPC745x line of CPUs.

  ===== arch/ppc/kernel/ppc_htab.c 1.7 vs edited =====
  TAG: v2.4.22-pre2

Maybe I'm missing something?
