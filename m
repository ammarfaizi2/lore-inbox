Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131583AbRAXRu5>; Wed, 24 Jan 2001 12:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131576AbRAXRuh>; Wed, 24 Jan 2001 12:50:37 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:28381 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S131568AbRAXRua>; Wed, 24 Jan 2001 12:50:30 -0500
Message-ID: <3A6F15CC.286D1F05@Home.net>
Date: Wed, 24 Jan 2001 12:50:05 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@innominate.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1542!(2.4.1-pre9)
In-Reply-To: <3A6C5058.C5AA7681@zaralinux.com> <3A6CB620.469A15A9@Home.net> <3A6ED16E.E8343678@innominate.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

True, It's just odd that we're having the same problem with the X server, so its
a double whammy ;)
Daniel Phillips wrote:

> Shawn Starr wrote:
> > This is not a kernel bug, This is a bug in the XFree86 TrueType rendering
> > extention. This has been discussed on the Xpert XFree86 mailing list. There
> > is a fix in the works (depends on the TrueType fonts your using).
>
> A BUG is a BUG:
>
> > > kernel BUG at slab.c:1542!
>
> The kernel should never oops, no matter what user space does to it.
>
> --
> Daniel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
