Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135511AbRDSTzJ>; Thu, 19 Apr 2001 15:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135364AbRDSTy7>; Thu, 19 Apr 2001 15:54:59 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:4873 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135497AbRDSTxo>; Thu, 19 Apr 2001 15:53:44 -0400
Date: Thu, 19 Apr 2001 16:53:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: <linux-lvm@sistina.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jes Sorensen <jes@linuxcare.com>, <linux-kernel@vger.kernel.org>,
        <linux-openlvm@nl.linux.org>, Arjan van de Ven <arjanv@redhat.com>,
        Jens Axboe <axboe@suse.de>, Martin Kasper Petersen <mkp@linuxcare.com>
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
In-Reply-To: <200104191945.f3JJjKRn015661@webber.adilger.int>
Message-ID: <Pine.LNX.4.33.0104191650050.17635-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2001, Andreas Dilger wrote:

> I don't think that the subscription is necessarily the only
> issue.  I'm subscribed to all of the LVM mailing lists, and
> still a lot of what I submit (legitimate bug fixes, and not just
> features/code cleanup) does not get added to CVS.  Yes, the
> no-possible-harm patches like man pages went in, but not other
> stuff.  Also, it doesn't appear that any of the LVM changes are
> making it into the stock kernel, which is basically a recepie
> for disaster.

This is indeed an even bigger problem.  LVM is no longer just
a Sistina product, it is an integrated part of the Linux kernel.

This brings with it the responsability of maintaining the LVM
subsystem which is included in the kernel. I understand that
Sistina may want to do "LVM releases" every once in a while,
but this isn't a development model that makes much sense when
their code has been integrated into the Linux kernel (IMHO).

> The openlvm list may change my mind, I'll see.

If you think any other openly accessible LVM development things
are needed (maybe a CVS tree which can be used by all LVM
developers and not just the Sistina folks?) .. NL.linux.org is
all yours.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

