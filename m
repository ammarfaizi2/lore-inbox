Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262265AbRENRDh>; Mon, 14 May 2001 13:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262268AbRENRD1>; Mon, 14 May 2001 13:03:27 -0400
Received: from baltazar.tecnoera.com ([200.29.128.1]:63753 "EHLO
	baltazar.tecnoera.com") by vger.kernel.org with ESMTP
	id <S262265AbRENRDQ>; Mon, 14 May 2001 13:03:16 -0400
Date: Mon, 14 May 2001 13:02:51 -0400 (CLT)
From: Juan Pablo Abuyeres <jpabuyer@tecnoera.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec RAID SCSI 2100S
In-Reply-To: <E14z6m5-00079E-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105141256470.4694-100000@baltazar.tecnoera.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Alan Cox wrote:

> > I'm trying to make this card work under 2.4.4, but I couldn't find a patch
> > anywhere to get it working under 2.4.x nor on 2.2.x. I tried with the I2O
> > kernel support, but it didn't work, it only reported errors after a pretty
> > long waiting :)
>
> You need to 2.4.4ac8 or higher for dpt i2o_scsi and 2.4.4ac5 or so or higher
> for dpt i2o_block

well, I applied 2.4.4ac8 (I couldn't find ac9) and I still have only
errors when recognizing the hardware. The long waiting is gone. I will try
to send the messages somehow. They were not saved on log files because it
couldn't mount the devices (and I don't have a spare disk to do the trick
:/)

Ideas?

