Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282323AbRKXBOy>; Fri, 23 Nov 2001 20:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282322AbRKXBOo>; Fri, 23 Nov 2001 20:14:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2055 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282323AbRKXBOg>; Fri, 23 Nov 2001 20:14:36 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: is 2.4.15 really available at www.kernel.org?
Date: 23 Nov 2001 17:14:11 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tms93$jqh$1@cesium.transmeta.com>
In-Reply-To: <7xpu69sttm.fsf@colargol.tihlde.org> <Pine.LNX.4.33.0111230523340.8063-100000@localhost.localdomain> <20011123151053.B13009@willow.seitz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011123151053.B13009@willow.seitz.com>
By author:    Ross Vandegrift <ross@willow.seitz.com>
In newsgroup: linux.dev.kernel
>
> > then i'm just plain baffled.  using mozilla, i've tried downloading both 
> > 2.4.15 and 2.5.0, from the main www.kernel.org page, and from the kernel
> > subpage.  in *every* case, the download window starts off fine with
> > "0K of 28716K", so it knows the right size at the beginning.
> 
> Turn your MTU down to 1490, maybe smaller.  There is a broken TCP/IP stack 
> or switch between you and kernel.org.
> 

I was just going to ask... is there a problem with either (a) Path MTU
Discovery or (b) Explicit Congestion Notification?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
