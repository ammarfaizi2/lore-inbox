Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266780AbRGFSUA>; Fri, 6 Jul 2001 14:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266781AbRGFSTu>; Fri, 6 Jul 2001 14:19:50 -0400
Received: from cr213096-a.rchrd1.on.wave.home.com ([24.114.243.186]:27396 "EHLO
	phobos.sharif.edu") by vger.kernel.org with ESMTP
	id <S266780AbRGFSTj>; Fri, 6 Jul 2001 14:19:39 -0400
Date: Fri, 6 Jul 2001 14:15:27 -0400 (EDT)
From: Masoud <masu@phobos.sharif.edu>
To: Ariel Molina Rueda <amolina@fismat.umich.mx>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Via82cxxx Codec rate locked at 48Khz
In-Reply-To: <Pine.LNX.4.33.0107061215400.32589-100000@garota.fismat.umich.mx>
Message-ID: <Pine.LNX.4.33.0107061413211.2034-100000@phobos.sharif.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Ariel Molina Rueda wrote:

>
> Greetings:
>
> When i used Redhat 7 and kernel 2.2.x y was happy with my souncard, now I
> use RedHat 7.1 and Kernel 2.4.x, but sndconfig doesn't configure my
> Via82c686 soundcard at all. At the ending it says
>
> via82cxxx codec rate locked at 48khz
>
> I use a Biostar MKE401B Matherboard with on-board sound (AC97)
>
> I've heard about patches for the intel chipsets, does anybody knows if one
> for my card has been released, or how to fix this problem...
> (my sound is  choppy and XMMS crashes!)
>
> something weird is that sound is good when Linus says:
> "Hi, Im Linus Torvalds, and...."
> then after sndconfig ends and sound is crying...
>
>

You might consider using ALSA sound drivers.
(http://www.alsa-project.org).
Does any body know when they'd merge with mainstream kernel?
(or are they going to be merged with kernel at all or not?)
cheers,
Masoud Sharbiani

