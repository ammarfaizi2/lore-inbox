Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319599AbSIHM2d>; Sun, 8 Sep 2002 08:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319600AbSIHM2d>; Sun, 8 Sep 2002 08:28:33 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:10448 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S319599AbSIHM2d> convert rfc822-to-8bit; Sun, 8 Sep 2002 08:28:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
To: Alexander Hoogerhuis <alexh@ihatent.com>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: Linux 2.4.20-pre5-ac4
Date: Sun, 8 Sep 2002 14:32:53 +0200
User-Agent: KMail/1.4.2
Cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
References: <Pine.NEB.4.44.0209081321200.7218-100000@mimas.fachschaften.tu-muenchen.de> <m3sn0khgwh.fsf@lapper.ihatent.com>
In-Reply-To: <m3sn0khgwh.fsf@lapper.ihatent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209081432.53278.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 September 2002 13:14, Alexander Hoogerhuis wrote:
> Adrian Bunk <bunk@fs.tum.de> writes:
> > On 8 Sep 2002, Alexander Hoogerhuis wrote:
> > >...
> > > CPU:    0
> > > EIP:    0010:[<c01f83e8>]    Tainted: PF
> > >...
> >
> > Which non-free modues (NVidia?) were loaded on your computer? Is the
> > problem reproducible without any non-free module loaded _ever_ since the
> > last reboot?
> >
> > > ttfn,
> > > A
>
> Ops, completely forgot that, vmware 3.1.1, I'll get it built without
> preempt and no vmware and see if it still blows up :) my bad :)
>

Ahh, I see. vmware tainted the kernel. Will retry without later today.

> mvh,
> A

Sorry guys,
hp
