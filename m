Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269540AbRHQDEp>; Thu, 16 Aug 2001 23:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269517AbRHQDEf>; Thu, 16 Aug 2001 23:04:35 -0400
Received: from TYO202.gate.nec.co.jp ([202.247.6.41]:35340 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S269540AbRHQDE1>; Thu, 16 Aug 2001 23:04:27 -0400
Message-ID: <3B7C89CF.7532DA72@ntsp.nec.co.jp>
Date: Fri, 17 Aug 2001 11:04:47 +0800
From: "Adrian V. Bono" <AdrianB@ntsp.nec.co.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Hollis <goemon@anime.net>
CC: Bob Martin <bmartin@ayrix.net>, linux-kernel@vger.kernel.org
Subject: Re: Via chipset
In-Reply-To: <Pine.LNX.4.30.0108161406270.15558-100000@anime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis wrote:
> 
> On Thu, 16 Aug 2001, Bob Martin wrote:
> > I have a MSI-6195 slot-A , AMD chipset with a visiontek nvidia vanta 32mb agp
> > [...]
> > related or not, probably not. I suspect xscreensaver is triggering something in
> > the xserver that is not normally getting hit in normal use.
> 
> Its probably the vanta.
> 
> xscreensaver is most likely starting one of the GL screensavers.
> 
> xfree86 opengl does not like the vanta on any of my systems -- intel or
> amd. it locks up after ~10-15 sec of running a gl app.
> 

I think i'd have to disagree. I have a PII-450 with a cheapo Vanta card
in it, and i run GL apps ranging from Quake 3 to various GL programs of
my own... no hangs. And i leave my system for days on end with a GL
screensaver running. Still no hangs. I've used NVidia drivers all the
way from 0.9-6 to 1.0-1251 and i never got that kind of instability.
