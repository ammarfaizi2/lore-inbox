Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289022AbSANUbE>; Mon, 14 Jan 2002 15:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289024AbSANU3i>; Mon, 14 Jan 2002 15:29:38 -0500
Received: from 216-21-153-9.ip.van.radiant.net ([216.21.153.9]:28935 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S288992AbSANU23>;
	Mon, 14 Jan 2002 15:28:29 -0500
Date: Mon, 14 Jan 2002 13:01:55 +0000 (/etc/localtime)
From: <gmack@innerfire.net>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery --
 the elegant solution)
In-Reply-To: <20020114145035.E17522@thyrsus.com>
Message-ID: <Pine.LNX.4.21.0201141255040.21227-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Eric S. Raymond wrote:

> Date: Mon, 14 Jan 2002 14:50:35 -0500
> From: Eric S. Raymond <esr@thyrsus.com>
> To: arjan@fenrus.demon.nl
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery
>     -- the elegant solution)
> "Crap." Melvin thinks.  "I don't remember what kind of network card I
> compiled in.  Am I going to have to open this puppy up just to eyeball
> the hardware?" Doing that would take time Melvin was planning to spend
> chatting up a girl geek he's noticed over at the computer lab.

BTDT queried the current kernel for the info I needed.

ISA doesn't look like it was designed to be autodetected at least not the
really old stuff.. if it's on a 586 it's likely to be at least PnP and
therefore more easilly detectable.

IMO ISA was designed for techies and not for J Random User.


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

