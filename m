Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLAJwx>; Fri, 1 Dec 2000 04:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129434AbQLAJwn>; Fri, 1 Dec 2000 04:52:43 -0500
Received: from max.phys.uu.nl ([131.211.32.73]:54285 "EHLO max.phys.uu.nl")
	by vger.kernel.org with ESMTP id <S129340AbQLAJwZ>;
	Fri, 1 Dec 2000 04:52:25 -0500
Date: Fri, 1 Dec 2000 10:21:56 +0100 (MET)
From: Dries van Oosten <D.vanOosten@phys.uu.nl>
To: Dax Kelson <dax@gurulabs.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 routing problem
In-Reply-To: <Pine.SOL.4.30.0012010214460.5548-100000@ultra1.inconnect.com>
Message-ID: <Pine.OSF.4.30.0012011020410.15665-100000@ruunat.phys.uu.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2000, Dax Kelson wrote:

> Dries van Oosten said once upon a time (Fri, 1 Dec 2000):
>
> > Can someone point me to how routing is done in the 2.4 kernel?
> > My net-tools don't work anymore (specifically route fails to produce the
> > routing table). I look around a bit in the kernel sources and notice
> > things have changed. What kind of options are there now to influence the
> > routing table?
>
> My net-tools v1.56 that comes with Red Hat 7 works fine.
>
> If you want to take full advantage of all the networking features, you
> need to use iproute2.
>
> ftp://ftp.inr.ac.ru/ip-routing/iproute2-2.2.4-now-ss??????.tar.gz

I downloaded and compiled them and they don't work as well.
What am I missing here?

Groeten,
Dries


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
