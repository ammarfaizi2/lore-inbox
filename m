Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284786AbRL1Xux>; Fri, 28 Dec 2001 18:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284795AbRL1Xun>; Fri, 28 Dec 2001 18:50:43 -0500
Received: from dsl-213-023-043-233.arcor-ip.net ([213.23.43.233]:52493 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S284786AbRL1Xuj>;
	Fri, 28 Dec 2001 18:50:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Legacy Fishtank <garzik@havoc.gtf.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] rlimit_nproc
Date: Sat, 29 Dec 2001 00:53:50 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0112271816380.12225-100000@duckman.distro.conectiva> <Pine.LNX.4.33.0112271224590.1167-100000@penguin.transmeta.com> <20011227163538.D23942@havoc.gtf.org>
In-Reply-To: <20011227163538.D23942@havoc.gtf.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16K6p1-0000BC-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 27, 2001 10:35 pm, Legacy Fishtank wrote:
> On Thu, Dec 27, 2001 at 12:35:38PM -0800, Linus Torvalds wrote:
> > Also worthwhile for automation is an md5sum or similar (for verifying that
> > the mail made it though the mail system unscathed). A pgp signature would
> > be even better, of course - especially useful as I suspect it would be
> > good to also cc the things to some patch-list, and having a clear identity
> > on the sender is always a good idea in these things.
> 
> I've been thinking that a "patches@kernel.org" dumping ground would be
> useful.
> 
> This is NOT intended as a patch tracker.  This is NOT intended as a
> substitution for submitting the patch to you, but instead intended
> as a patch archive that doesn't go away.  We have seen linux-kernel
> archives come and go, or drop messages.  But a patch archive would be
> useful...  I'm not sure a mailing list proper is right for the job,
> since I want to support the reception and archiving of multi-megabyte
> patches at times.

Exactly what I was thinking of: 'linux-patches@kernel.org'.  The idea is, 
instead of putting [PATCH] on your subject line and cc'ing it to Linus, you 
mail it to linux-patches with a cc to lkml if you like (depending on size of 
patch, how interesting, etc).  In any event, linux-patches will forward a 
copy to Linus.

--
Daniel
