Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284850AbRLPWKe>; Sun, 16 Dec 2001 17:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284871AbRLPWKY>; Sun, 16 Dec 2001 17:10:24 -0500
Received: from ppp-105-9.29-151.libero.it ([151.29.9.105]:47353 "HELO
	blu.blu.i.prosa.it") by vger.kernel.org with SMTP
	id <S284850AbRLPWKG>; Sun, 16 Dec 2001 17:10:06 -0500
Date: Sun, 16 Dec 2001 23:02:06 +0100
From: antirez <antirez@invece.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
Message-ID: <20011216230206.J446@blu>
Reply-To: antirez <antirez@invece.org>
In-Reply-To: <3C1D060B.9475C9F8@bluewin.ch> <9vj2c7$vgr$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9vj2c7$vgr$1@cesium.transmeta.com>; from hpa@zytor.com on Sun, Dec 16, 2001 at 01:06:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2001 at 01:06:15PM -0800, H. Peter Anvin wrote:
> Followup to:  <3C1D060B.9475C9F8@bluewin.ch>
> By author:    Otto Wyss <otto.wyss@bluewin.ch>
> In newsgroup: linux.dev.kernel
> > 
> > Disadvantages:
> > - Someone else has to do it, I'm not a kernel/driver developer
> > 
> 
> By this you have pretty much shown yourself utterly unqualified to be
> a kernel *designer*.  I won't even go into the various bogus

Agreed, but it should be also noted that to be able to do
kernel coding is insufficient to do kernel design.
The same for user space, to be able to write correct C (or .*)
will not stop people to write code with unsane design, organization
and data structures.

You can see it on freshmeat and in many popular kernels every day.
I see it with my code every time I read my last-month source code.

-- 
Salvatore Sanfilippo <antirez@invece.org>
http://www.kyuzz.org/antirez
finger antirez@tella.alicom.com for PGP key
28 52 F5 4A 49 65 34 29 - 1D 1B F6 DA 24 C7 12 BF
