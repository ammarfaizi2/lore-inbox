Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272795AbRIMWqI>; Thu, 13 Sep 2001 18:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272782AbRIMWp6>; Thu, 13 Sep 2001 18:45:58 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:7625 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S272774AbRIMWpv>;
	Thu, 13 Sep 2001 18:45:51 -0400
Date: Fri, 14 Sep 2001 00:46:13 +0200 (CEST)
From: Eric Lammerts <eric@lammerts.org>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Booting linux using Novell NetWare Remote Program Loader
In-Reply-To: <88lneREmw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.33.0109140038200.10430-100000@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 Sep 2001, Kai Henningsen wrote:

> eric@lammerts.org (Eric Lammerts)  wrote on 09.09.01 in <Pine.LNX.4.33.0109092306580.11042-100000@ally.lammerts.org>:
>
> > I used to have Netware bootroms that didn't do RPL. They talked NCP
> > (like every other Netware client) and read a floppy image from
> > SYS:LOGIN. I never tried them with mars_nwe though.
>
> What do you mean, "didn't do RPL"? That *is* how Novell RPL works. Also
> has a configfile under SYS:LOGIN where you can assign images to MAC
> addresses. Well, MAC address + IPX network pairs, IIRC. It's been a while.

It's a long time ago, but I remember reading documentation on RPL and
non-RPL bootroms. What I know for sure is that my bootroms worked
without loading RPL.NLM on the server.

Eric

