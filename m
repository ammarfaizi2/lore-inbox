Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLAJsx>; Fri, 1 Dec 2000 04:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129340AbQLAJsn>; Fri, 1 Dec 2000 04:48:43 -0500
Received: from mail.inconnect.com ([209.140.64.7]:19185 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S129314AbQLAJs1>; Fri, 1 Dec 2000 04:48:27 -0500
Date: Fri, 1 Dec 2000 02:18:00 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: Dries van Oosten <D.vanOosten@phys.uu.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 routing problem
In-Reply-To: <Pine.OSF.4.30.0012011006130.5824-100000@ruunat.phys.uu.nl>
Message-ID: <Pine.SOL.4.30.0012010214460.5548-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dries van Oosten said once upon a time (Fri, 1 Dec 2000):

> Can someone point me to how routing is done in the 2.4 kernel?
> My net-tools don't work anymore (specifically route fails to produce the
> routing table). I look around a bit in the kernel sources and notice
> things have changed. What kind of options are there now to influence the
> routing table?

My net-tools v1.56 that comes with Red Hat 7 works fine.

If you want to take full advantage of all the networking features, you
need to use iproute2.

ftp://ftp.inr.ac.ru/ip-routing/iproute2-2.2.4-now-ss??????.tar.gz

Dax Kelson
Guru Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
