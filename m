Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287374AbRL3KQP>; Sun, 30 Dec 2001 05:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287375AbRL3KQF>; Sun, 30 Dec 2001 05:16:05 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:4139 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S287374AbRL3KP5> convert rfc822-to-8bit; Sun, 30 Dec 2001 05:15:57 -0500
Date: Sun, 30 Dec 2001 12:16:51 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: CJ <cj@cjcj.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@codemonkey.org.uk>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Dave Jones <davej@suse.de>, Chuck Lever <cel@monkey.org>
Subject: Re: Possible O_DIRECT problems ?
In-Reply-To: <Pine.LNX.4.10.10112292138250.32522-100000@master.linux-ide.org>
Message-ID: <20011230120352.Y780-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Dec 2001, Andre Hedrick wrote:

> On Sat, 29 Dec 2001, CJ wrote:
>
> > Shouldn't O_DIRECT's requirements come from the hardware?  If we can
> > ASPI or CAM DMA SCSI devices to odd addresses and lengths, why not
> > O_DIRECT?  Do ape drives DMA to user buffers?  Are O_DIRECT's
> > current limits gratuitous?
>
> CAM is a very bad thing and that is why the X3 committees split.

There were interesting guide-lines in CAM, notably the topology handling
and the error recovery scheme. But it was another different wheel in a
world where everybody did reinvent its own. It seemed also very DEC
tainted.

Btw, given guys like you in X3 committees, I am not surprised that splits
occur in this place. :-)

  Gérard.

PS: Your various email addresses bounce back claiming some ridiculous
text about spammers. Is this still another show of your apparent
existential complex.

