Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270031AbRHQJxD>; Fri, 17 Aug 2001 05:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270025AbRHQJwx>; Fri, 17 Aug 2001 05:52:53 -0400
Received: from cnxt10002.conexant.com ([198.62.10.2]:56424 "EHLO
	sophia-sousar2.nice.mindspeed.com") by vger.kernel.org with ESMTP
	id <S270031AbRHQJwn>; Fri, 17 Aug 2001 05:52:43 -0400
Date: Fri, 17 Aug 2001 11:52:15 +0200 (CEST)
From: <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@sophia-sousar2.nice.mindspeed.com>
To: Krishnakumar B <kitty@cs.wustl.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Bass & Treble no longer work with emu10k1 on Linux-2.4.9
In-Reply-To: <15228.22838.327612.439034@samba.doc.wustl.edu>
Message-ID: <Pine.LNX.4.33.0108171149120.9296-100000@sophia-sousar2.nice.mindspeed.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, Krishnakumar B wrote:

> Hi,
>
> I upgraded my kernel to Linux-2.4.9. Bass & Treble controls no longer work
> (I don't see any entry in any of the mixer utils that I have) with my
> SoundBlaster Live! card.

You need new user space tools to get this going. They are available at:

http://opensource.creative.com/dist.html

> It works fine with Linux-2.4.8-ac3 which is the
> latest -ac series that I have tried. gmix shows TriTech TR????? whereas it
> used to show Creative SoundBlaster Live! previously.

This is normal. Your card has a TriTech ac97 codec.

> Any help is appreciated.

Rui Sousa

