Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136136AbRDVN4c>; Sun, 22 Apr 2001 09:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136134AbRDVN4R>; Sun, 22 Apr 2001 09:56:17 -0400
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:50439 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S136128AbRDVNz6>; Sun, 22 Apr 2001 09:55:58 -0400
Date: Sun, 22 Apr 2001 14:42:29 +0100 (BST)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: Request for comment -- a better attribution system
In-Reply-To: <20010422131234.B20807@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0104221433110.12740-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Apr 2001, Russell King wrote:

> > C: CONFIG_SCSI_BLARG
> > F: drivers/scsi/blarg.c
> > F: drivers/scsi/blarg.h

> And what would:
>
> C: CONFIG_ARM
>
> tell you?  Nothing that is not described in the rest of the "ARM PORT"
> entry.

True, but it would tell it to a script without intervention.

Eric wants an easy way to find the owner of a CONFIG_ entry.
True, the consensus seems to be that this isn't a particularly
useful thing to do, but if it must be done, this seems like an
eminently sane way to do it.

Matthew.

