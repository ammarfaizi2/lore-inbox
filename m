Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289055AbSA3KVR>; Wed, 30 Jan 2002 05:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289062AbSA3KVC>; Wed, 30 Jan 2002 05:21:02 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:35750 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289057AbSA3KTX>; Wed, 30 Jan 2002 05:19:23 -0500
Date: Wed, 30 Jan 2002 12:14:12 +0200 (SAST)
From: Zwane Mwaikambo <zwane@commfireservices.com>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Diego Calleja <grundig@teleline.es>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: fonts corruption with 3dfx drm module
In-Reply-To: <20020128203706.24AC0FB8D@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0201301213300.2730-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 xxx -1, Diego Calleja wrote:

> On 28 ene 2002, 16:12:34, Zwane Mwaikambo wrote:
> > 
> > On Mon, 28 Jan 2002, Zwane Mwaikambo wrote:
> > 
> > > Do you guys have CONFIG_MTRR and/or CONFIG_FB_VESA enabled? Also which 
> > > motherboard chipset?
> I have CONFIG_MTRR enabled. CONFIG_FB_VESA is disabled.
> Moterhboard: MS-5571
> Chipset: SIS 5571 Trinity, Video card voodoo 3 3000 PCI
> > 
> > Forgot to mention, which XFree86 version?
> 
> X 4.1.0 (debian woody release)
> 

Can you try reproduce the font corruption with CONFIG_MTRR disabled, just 
for my amusement. I would greatly appreciate it.

Cheers,
	Zwane Mwaikambo


