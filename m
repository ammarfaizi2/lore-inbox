Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268150AbTCCAqI>; Sun, 2 Mar 2003 19:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268156AbTCCAqI>; Sun, 2 Mar 2003 19:46:08 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:46496 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S268150AbTCCAqF>; Sun, 2 Mar 2003 19:46:05 -0500
From: David Lang <david.lang@digitalinsight.com>
To: nickn <nickn@www0.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Date: Sun, 2 Mar 2003 16:55:03 -0800 (PST)
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
In-Reply-To: <20030303004728.GA5856@www0.org>
Message-ID: <Pine.LNX.4.44.0303021651560.17904-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm a little confused about the on-disk format

is it SCCS and the problem is that CSSC doesn't recognise everything that
the latest SCCS does so a patch is needed for CSSC or does it differ
slightly from SCCS?

Larry has mentioned that there were things they changed from the base SCCS
format that they started with, but he indicated that they had fed patches
to SCCS to use the new info.

I'm trying to figure out if the problem is CSSC not being as compatible as
it would like to be or is larry not getting the changes he is proposing
into SCCS, or are there other problems.

David Lang


On Mon, 3 Mar 2003, nickn wrote:

> Date: Mon, 3 Mar 2003 00:47:28 +0000
> From: nickn <nickn@www0.org>
> To: Jeff Garzik <jgarzik@pobox.com>
> Cc: H. Peter Anvin <hpa@zytor.com>, linux-kernel@vger.kernel.org
> Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
>
> On Sun, Mar 02, 2003 at 12:12:58PM -0500, Jeff Garzik wrote:
> > My counter-question is, why not improve an _existing_ open source SCM to
> > read and write BitKeeper files?  Why do we need yet another brand new
> > project?
>
> Or improve BK to export and import on demand of an existing open source SCM.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
