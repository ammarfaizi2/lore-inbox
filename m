Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286413AbSBGJBx>; Thu, 7 Feb 2002 04:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSBGJBn>; Thu, 7 Feb 2002 04:01:43 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:56540 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S286413AbSBGJBa>;
	Thu, 7 Feb 2002 04:01:30 -0500
Date: Thu, 7 Feb 2002 10:01:05 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with iso9660 as initrd
In-Reply-To: <a3te3d$7f2$1@cesium.transmeta.com>
Message-ID: <Pine.GSO.4.30.0202071000170.12660-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Followup to:  <m3n0yl90xb.fsf@borg.borderworlds.dk>
> By author:    Christian Laursen <xi@borderworlds.dk>
> In newsgroup: linux.dev.kernel
> > >
> > > Also, you don't have CONFIG_ZISOFS set...
> >
> > Sorry for not being precise enough. It is not a zisofs, just compressed
> > with gzip as usual for an initrd image.
> >
>
> Still unusual, though.  Why iso9660?  It's not particularly well
> suited for an initrd, especially because of all the redundant data
> structures and extra blocking.

But even if it was zisofs, the kernel shouldn't give oops, should it?


-- 
pozsy

