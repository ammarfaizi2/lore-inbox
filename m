Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135519AbRDWTm2>; Mon, 23 Apr 2001 15:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135522AbRDWTmS>; Mon, 23 Apr 2001 15:42:18 -0400
Received: from cnxt10143.conexant.com ([198.62.10.143]:11276 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S135519AbRDWTmH>; Mon, 23 Apr 2001 15:42:07 -0400
Date: Mon, 23 Apr 2001 21:41:49 +0200 (CEST)
From: <rui.sousa@mindspeed.com>
X-X-Sender: <rsousa@localhost.localdomain>
To: "Gary White (Network Administrator)" <admin@netpathway.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: KDE Lockups with emu10k1 driver in kernel > 2.4.3-ac9
In-Reply-To: <3AE47F9E.D8CF4B1B@netpathway.com>
Message-ID: <Pine.LNX.4.33.0104232140340.1417-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2001, Gary White (Network Administrator) wrote:

There are no emu10k1 changes from ac9 up to ac12...
Do you have a VIA motherboard by any chance?

Rui Sousa

> Since ac9 I started having a lockup when initializing KDE 2.1.1.
> Did not think that much about it since my installation has had libs
> upgraded and patched for months. Today I decided to do a clean
> distribution install and after I had the same problem. Removing
> each module one at a time I finally narrowed in down to the
> Sound Blaster Live module. Every version including ac9 and
> before works fine. Has anybody else had this problem?
>
> --
> Gary White               Network Administrator
> admin@netpathway.com          Internet Pathway
> Voice 601-776-3355            Fax 601-776-2314
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

