Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbRGATAn>; Sun, 1 Jul 2001 15:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264912AbRGATAc>; Sun, 1 Jul 2001 15:00:32 -0400
Received: from polypc17.chem.rug.nl ([129.125.25.92]:39554 "EHLO
	polypc17.chem.rug.nl") by vger.kernel.org with ESMTP
	id <S264908AbRGATAW>; Sun, 1 Jul 2001 15:00:22 -0400
Date: Sun, 1 Jul 2001 21:00:19 +0200 (CEST)
From: "J.R. de Jong" <jdejong@chem.rug.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 NFS io errors
In-Reply-To: <shsvglfyzve.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.21.0107012057410.12796-100000@polypc17.chem.rug.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope, I'm using hard ones.

- Johan.

---

Yoda of Borg are we: Futile is resistance. Assimilate you, we will.

On 29 Jun 2001, Trond Myklebust wrote:

> >>>>> " " == J R de Jong <J.R.> writes:
> 
>      > Hi all, Recently I upgraded from 2.4.4 to 2.4.5, but after that
>      > I got users complaining about io errors on some mounted NFS
>      > systems on some files, whenever they tried to stat (ls) or open
>      > the file. Even after several reboots (other files failed tho).
> 
>      > Going back to 2.4.4 solved the problem. I don't know if this
>      > problem has been adressed already.
> 
> Sounds like you're using soft mounts?
> 
> Cheers,
>    Trond
> 

