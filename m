Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266924AbRGHQ73>; Sun, 8 Jul 2001 12:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266925AbRGHQ7U>; Sun, 8 Jul 2001 12:59:20 -0400
Received: from fepout3.telus.net ([199.185.220.238]:32798 "EHLO
	priv-edtnes11-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id <S266924AbRGHQ7N>; Sun, 8 Jul 2001 12:59:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Brad Pepers <brad@linuxcanada.com>
Organization: Linux Canada Inc.
To: Pavel Machek <pavel@suse.cz>
Subject: Re: For comment: draft BIOS use document for the kernel
Date: Sun, 8 Jul 2001 10:59:02 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15DTfd-0003gI-00@the-village.bc.nu> <01062211113100.01758@dragon.linuxcan.com> <20010630144733.C255@toy.ucw.cz>
In-Reply-To: <20010630144733.C255@toy.ucw.cz>
MIME-Version: 1.0
Message-Id: <01070810590200.18804@dragon.linuxcan.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 June 2001 08:47, Pavel Machek wrote:
> Hi!
>
> > > 1.3	Type 'apm -s'
> > > 	The machine should standby
> > >
> > > 1.4	Wake it and type 'apm -S'
> > > 	The machine should suspend
> >
> > According to the man pages, "apm -s" does a suspend and "apm -S" does a
> > standby.
>
> No, original seems good.
>
> apm -s: suspend to ram
> apm -S: suspend to disk

The apm man pages do not mention suspend to ram vrs suspend to disk but only 
suspend vrs standby as Alan did and they say its the other way around.  So 
are the man pages wrong then?

-- 
Brad Pepers
brad@linuxcanada.com
