Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263327AbSJFEpJ>; Sun, 6 Oct 2002 00:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263334AbSJFEpJ>; Sun, 6 Oct 2002 00:45:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21642 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263327AbSJFEpI>;
	Sun, 6 Oct 2002 00:45:08 -0400
Date: Sat, 05 Oct 2002 21:43:37 -0700 (PDT)
Message-Id: <20021005.214337.111206582.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: lm@bitmover.com, drepper@redhat.com, bcollins@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1033861827.4441.31.camel@irongate.swansea.linux.org.uk>
References: <3D9F49D9.304@redhat.com>
	<20021005162852.I11375@work.bitmover.com>
	<1033861827.4441.31.camel@irongate.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 06 Oct 2002 00:50:27 +0100

   Linus used to do about a patch every 2 days. Nowdays its a lot slower. I
   put that down to buttkeeper

You can get up to hourly patch snapshots, and the so-called
buttkeeper is what makes that possible.  Ask Rik or Jgarzik,
as I believe those are two folks who provide this service.

To me the ftp site patches serve what they should have always served,
as major checkpoints.  The every-2-day patch thing was necessary back
then because we had no other window into what was in Linus's tree
at any given point in time.  Which was truly brutal for folks that
needed to be merging with him on a daily basis just to keep the
backlog in check.

Now we have tons of windows into his live tree, some use bitkeeper
others are in purely patch form and do not require the use of
bitkeeper.  You can even click on a website to see "did Linus eat that
XXX diff I sent him 2 hours ago?"

By all accounts, information is more available than it used to be.
In fact, the information is available in so many formats and sources
that you have quite a wide selection of how you get it.

People like Andrew Morton even publish the "snapshot as of two hours
ago" diffs of Linus's tree against the most recent FTP patch in their
patch sets.
