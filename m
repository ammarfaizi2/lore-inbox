Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267287AbTAAPQX>; Wed, 1 Jan 2003 10:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267288AbTAAPQX>; Wed, 1 Jan 2003 10:16:23 -0500
Received: from [81.2.122.30] ([81.2.122.30]:25095 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267287AbTAAPQW>;
	Wed, 1 Jan 2003 10:16:22 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301011524.h01FOaZ6001581@darkstar.example.net>
Subject: Re: a few more "make xconfig" inconsistencies
To: szepe@pinerecords.com (Tomas Szepe)
Date: Wed, 1 Jan 2003 15:24:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030101151107.GN14184@louise.pinerecords.com> from "Tomas Szepe" at Jan 01, 2003 04:11:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Oh, I see what you mean.  This behavior is a "feature" of the old
> > > xconfig (it's been so since the 2.0 times or thereabouts). menuconfig
> > > will hide entirely what xconfig merely grays out.
> > 
> > I actually like that feature :-(.
> > 
> > On the other hand, the TCL-based config system has gone completely in
> > 2.5.  I look forward to the 2.7 tree opening when hopefully somebody
> > will bring it back as an extra choice, just for the sake of it :-).
> 
> The new config system provides a generic library for handling kernel
> configuration.  My bet is we can expect lots of kernel config frontends
> turning up as soon as 2.6 sees the light of the world (and people find
> out how great it is :D).

Cool - the big disadvantage of the QT-based kernel configurator is
that it takes ages to load on slow boxes, (even on my MMX-200 it's
slow, and that's not _that_ old).

John.
