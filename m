Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133097AbRD3VRJ>; Mon, 30 Apr 2001 17:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135909AbRD3VQ6>; Mon, 30 Apr 2001 17:16:58 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:2380 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S133097AbRD3VQu>; Mon, 30 Apr 2001 17:16:50 -0400
Date: Mon, 30 Apr 2001 23:15:51 +0200
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: "Mohammad A . Haque" <mhaque@haque.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jinbo21@hananet.net,
        linux-kernel@vger.kernel.org
Subject: Re: buz.c of 2.4.4
Message-ID: <20010430231551.A11965@tux.bitfreak.net>
In-Reply-To: <E14uI6W-0008Kl-00@the-village.bc.nu> <Pine.LNX.4.33.0104301436280.29480-100000@viper.haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.33.0104301436280.29480-100000@viper.haque.net>; from mhaque@haque.net on Mon, Apr 30, 2001 at 20:37:39 +0200
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.04.30 20:37:39 +0200 Mohammad A. Haque wrote:
> On Mon, 30 Apr 2001, Alan Cox wrote:
> 
> > Buz.c doesnt work build or anything. Once the zoran merge is done it
> will
> > go away, until then I simply dont care.  At least its obviously broken
> right
> > now
> 
> Can't we just remove it then?
> 
> Come to think of it .. then we'd start getting "buz drivers missing"
> reports.

So what?
Refer them to mjpeg-users@lists.sourceforge.net and we'll explain them how
to use the new zoran driver until it's in the official kernel...
I mean, it be worse if they _used_ the old buz-thing, they'd start bugging
you with "how do I fix it?"

A broken driver in the kernel basically means a broken kernel - so it'd be
better to just remove it I guess... What do you think, Alan?

--
Ronald Bultje

