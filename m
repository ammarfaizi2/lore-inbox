Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280343AbRKXW2b>; Sat, 24 Nov 2001 17:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280387AbRKXW2V>; Sat, 24 Nov 2001 17:28:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47369 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280343AbRKXW2P>; Sat, 24 Nov 2001 17:28:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Journaling pointless with today's hard disks?
Date: 24 Nov 2001 14:28:00 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tp6tg$mge$1@cesium.transmeta.com>
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <20011124103642.A32278@vega.ipal.net> <20011124184119.C12133@emma1.emma.line.org> <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <tgy9kwf02c.fsf@mercury.rus.uni-stuttgart.de>
By author:    Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
In newsgroup: linux.dev.kernel
> 
> > However, if it's really true that DTLA drives and their successor
> > corrupt blocks (generate bad blocks) on power loss during block writes,
> > these drives are crap.
> 
> They do, even IBM admits that (on
> 
>         http://www.cooling-solutions.de/dtla-faq
> 
> you find a quote from IBM confirming this).  IBM says it's okay, you
> have to expect this to happen.  So much for their expertise in making
> hard disks.  This makes me feel rather dizzy (lots of IBM drives in
> use).
> 

No sh*t.  I have always been favouring IBM drives, and I had a RAID
system with these drives bought.  It will be a LONG time before I buy
another IBM drive, that's for sure.  I can't believe they don't even
have the decency of saying "we fucked".

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
