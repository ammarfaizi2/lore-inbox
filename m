Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSHGBIX>; Tue, 6 Aug 2002 21:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316609AbSHGBIX>; Tue, 6 Aug 2002 21:08:23 -0400
Received: from h53n2fls24o900.telia.com ([217.208.132.53]:1512 "EHLO
	oden.fish.net") by vger.kernel.org with ESMTP id <S316608AbSHGBIX>;
	Tue, 6 Aug 2002 21:08:23 -0400
Date: Wed, 7 Aug 2002 03:11:49 +0200
From: Voluspa <voluspa@bigfoot.com>
To: Zach Brown <zab@zabbo.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 MAESTRO sound /dev/dsp3 broken (luxury problem)
Message-Id: <20020807031149.7a9ea69f.voluspa@bigfoot.com>
In-Reply-To: <20020806155943.C15208@erasmus.off.net>
References: <20020806004059.43db99fb.voluspa@bigfoot.com>
	<1028593223.18478.129.camel@irongate.swansea.linux.org.uk>
	<20020806155943.C15208@erasmus.off.net>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002 15:59:43 -0400
Zach Brown <zab@zabbo.net> wrote:

> > Can you try and find out exactly which kernel it broke at. The only
> > maestro change Im aware of was in rc1-ac7 and wouldn't have that affect
> > in any way I can imagine..
> 
> I remember reports from the depths of time that dsp3 didn't work.  I
> wonder if there is some generation of chip that has a faulty set of high
> apus.

The embarrasing thing is, I can't boot back to a working kernel. Having completed a marathon compilation I discover that it doesn't work even where it used to. Almost as if something physical has been blown to smithereens.

I'm not (overly) crazy. It _did_ work in 2.4.19-pre10-ac1+preempt. RealOne Player was bound through the environment variable AUDIO=/dev/dsp3 and gqmpeg had been configured to use /dev/dsp2.

Btw, what I called 'a cry from the wilderness' is heavily distorted audio, at a volume about twice as high as the working channels are set to (which practically means maximum...)

You won't hear from me again unless a miracle happens...

Sorry to have wasted peoples time/bandwidth,
Mats Johannesson
