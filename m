Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279878AbRJ3Grp>; Tue, 30 Oct 2001 01:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279880AbRJ3Grf>; Tue, 30 Oct 2001 01:47:35 -0500
Received: from ssh-yyz.somanetworks.com ([216.126.67.45]:2321 "EHLO
	hydra.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S279878AbRJ3Gr3>; Tue, 30 Oct 2001 01:47:29 -0500
Date: Tue, 30 Oct 2001 01:48:00 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: opl3sa2 sound driver and mixers
In-Reply-To: <E15yK9H-00048j-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110300140020.20844-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Alan Cox wrote:

> > Please read Documentation/sound/OPL3-SA2 (the two mixers are intentional,
> > some channels are available only on the MSS mixer, others only on the
> > OPL3-SA2), and don't break the driver! Since the latest DMA fix finally
> > everything works fine on my Portege 3010 (which is exactly the same as the
> > 3020 except for a slower CPU and smaller disk).
>
> Thanks for warning me and saving me the effort of decoding it all

I've found myself too busy at work over the last while to really look into
any issues with this driver.  Anyone keen on taking over as maintainer?

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

