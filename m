Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273053AbRIIVKg>; Sun, 9 Sep 2001 17:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273055AbRIIVKV>; Sun, 9 Sep 2001 17:10:21 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:62416 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S273053AbRIIVKG>;
	Sun, 9 Sep 2001 17:10:06 -0400
Date: Sun, 9 Sep 2001 23:10:25 +0200 (CEST)
From: Eric Lammerts <eric@lammerts.org>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Pavel Machek <pavel@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
In-Reply-To: <20010909170206.A3245@redhat.com>
Message-ID: <Pine.LNX.4.33.0109092306580.11042-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Sep 2001, Benjamin LaHaise wrote:
> No need -- just search around for a copy of rpld.  I've got a few
> SiS based boards that netboot via rpl which rpld manages to handle
> like a charm.  Cheers,

I used to have Netware bootroms that didn't do RPL. They talked NCP
(like every other Netware client) and read a floppy image from
SYS:LOGIN. I never tried them with mars_nwe though.

Eric

