Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVDDUe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVDDUe2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVDDUdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:33:55 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.24]:52923 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261389AbVDDUaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:30:24 -0400
X-ME-UUID: 20050404203018601.92D5714000A1@mwinf0704.wanadoo.fr
Date: Mon, 4 Apr 2005 22:27:06 +0200
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org,
       Jes Sorensen <jes@trained-monkey.org>, linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050404202706.GB3140@pegasos>
References: <20050404100929.GA23921@pegasos> <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404183909.GI18349@parcelfarce.linux.theplanet.co.uk> <42519BCB.2030307@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <42519BCB.2030307@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 03:55:55PM -0400, Jeff Garzik wrote:
> Matthew Wilcox wrote:
> >On Mon, Apr 04, 2005 at 10:51:30AM -0700, Greg KH wrote:
> >
> >>Then let's see some acts.  We (lkml) are not the ones with the percieved
> >>problem, or the ones discussing it.
> >
> >
> >Actually, there are some legitimate problems with some of the files in
> >the Linux source base.  Last time this came up, the Acenic firmware was
> >mentioned:
> >
> >http://lists.debian.org/debian-legal/2004/12/msg00078.html
> >
> >Seems to me that situation is still not resolved.
> 
> And it looks like no one cares enough to make the effort to resolve this...
> 
> I would love an open source acenic firmware.

Yep, but in the meantime, let's clearly mark said firmware as
not-covered-by-the-GPL. In the acenic case it seems to be even easier, as the
firmware is in a separate acenic_firmware.h file, and it just needs to have
the proper licencing statement added, saying that it is not covered by the
GPL, and then giving the information under what licence it is being
distributed.

Jeff, since your name was found in the tg3.c case, and you seem to care about
this too, what is your take on this proposal ?

Friendly,

Sven Luther

