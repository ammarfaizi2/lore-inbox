Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131708AbRCXQid>; Sat, 24 Mar 2001 11:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131710AbRCXQiX>; Sat, 24 Mar 2001 11:38:23 -0500
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:8412
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S131708AbRCXQiM>; Sat, 24 Mar 2001 11:38:12 -0500
Date: Sat, 24 Mar 2001 17:37:34 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@tethys.fachschaften.tu-muenchen.de>
To: Boris Pisarcik <boris@acheron.sk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Cannot compile 2.4.2-ac23 kernel
In-Reply-To: <20010324162706.A10867@Boris>
Message-ID: <Pine.NEB.4.33.0103241736360.7576-100000@tethys.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2001, Boris Pisarcik wrote:

> Hello anybody.

Ho Boris,

>...
> setup.c: In function `identify_cpu':
> setup.c:2280: `tsc_disable' undeclared (first use in this function)
> setup.c:2280: (Each undeclared identifier is reported only once
> setup.c:2280: for each function it appears in.)
>
> and compilation stops.
>...
> Can somebody help me, what did i do wrong ?

Nothing. :-)

This is a known bug in 2.4.2ac23 that is fixed in 2.4.2ac24 .

> Thanks                                                                   B.

cu
Adrian

-- 

Nicht weil die Dinge schwierig sind wagen wir sie nicht,
sondern weil wir sie nicht wagen sind sie schwierig.

