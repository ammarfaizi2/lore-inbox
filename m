Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSANTFe>; Mon, 14 Jan 2002 14:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288922AbSANTEg>; Mon, 14 Jan 2002 14:04:36 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:44929 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S288932AbSANTDn>;
	Mon, 14 Jan 2002 14:03:43 -0500
Message-Id: <m16QCNJ-000OVeC@amadeus.home.nl>
Date: Mon, 14 Jan 2002 19:02:29 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: esr@thyrsus.com
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020114132618.G14747@thyrsus.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020114132618.G14747@thyrsus.com> you wrote:
> Not that I'm running down distro makers.  They do a valuable job, and in fact
> my approach relies on Aunt Tillie's machine starting life with an all-modular
> distro kernel.

> But the point of this game is for Aunt Tillie to have more and better
> choices.  Isn't that what we're supposed to be about?

While I'm absolutely not disputing the right of anyone to compile their own
kernel (I'm not trying to lock customers into my special platform like some
unnamed industrial giant *cough*), I just wonder why an AUTOMATIC generated
kernel with all the _relevant_ drivers modules will be "more and better"
than a (distro) kernel with _all_ drivers modules. That's the POINT of
modules -> be there or not, nothing else cares. If that's not the case
right now it's something we ought to fix first I'd say.

Of course there are other settings that do have impact (CPU type mostly,
maybe memory layout) but other than that... distros already ship several
binary versions (last I counted Red Hat ships 11 or so with RHL72) to
account for CPU type and amount etc.

Greetings,
   Arjan van d Ven
