Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbSJPU7b>; Wed, 16 Oct 2002 16:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJPU7a>; Wed, 16 Oct 2002 16:59:30 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6661 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261406AbSJPU7a>; Wed, 16 Oct 2002 16:59:30 -0400
Date: Wed, 16 Oct 2002 17:05:04 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
In-Reply-To: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1021016170140.12145C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Linus Torvalds wrote:

> 
> A huge merging frenzy for the feature freeze, although I also spent a few
> days getting rid of the need for ide-scsi.c and the SCSI layer to burn
> CD-ROM's with the IDE driver (it still needs an update to cdrecord, I sent 
> those off to the maintainer).

I hope you haven't broken running WITH ide-scsi, because most people still
run 2.4 kernels in real life and only test 2.5 because someone has to do
it. Reconfiguring the system to use ide-scsi or not is just one more PITA
thing which needs to be done, or more likely forgotten, with every new
kernel.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

