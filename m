Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271720AbRHUPcb>; Tue, 21 Aug 2001 11:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271721AbRHUPcW>; Tue, 21 Aug 2001 11:32:22 -0400
Received: from mx3.sac.fedex.com ([199.81.208.11]:6670 "EHLO mx3.sac.fedex.com")
	by vger.kernel.org with ESMTP id <S271720AbRHUPcE>;
	Tue, 21 Aug 2001 11:32:04 -0400
Date: Tue, 21 Aug 2001 23:33:14 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andris Pavenis <pavenis@latnet.lv>, <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio doesn't work with 2.4.9
In-Reply-To: <E15ZC3v-0007tI-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108212332480.4687-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it works for me on 2.4.9.


Thanks,
Jeff
[ jchua@fedex.com ]

On Tue, 21 Aug 2001, Alan Cox wrote:

> > i810 audio didn't work for me with kernel 2.4.9 (artsd from KDE goes into infinite loop, no sound).
> >
> > Reverting to kernel 2.4.7 or replacing in 2.4.9 drivers/sound/ac97_codec.c, drivers/sound/i810_audio.c,
> > include/linux/ac97_codec.h from 2.4.8-ac8 fixed the problem for me
>
> Thats good to know - the 2.4.8-ac8 one is scheduled to go to Linus
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

