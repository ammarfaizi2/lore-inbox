Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSIPGOX>; Mon, 16 Sep 2002 02:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSIPGOX>; Mon, 16 Sep 2002 02:14:23 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:42172 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S311025AbSIPGOW>;
	Mon, 16 Sep 2002 02:14:22 -0400
Message-ID: <1032157154.3d8577e224791@kolivas.net>
Date: Mon, 16 Sep 2002 16:19:14 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: Re: System response benchmarks in performance patches
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill

Quoting Bill Davidsen <davidsen@tmr.com>:

> On Sat, 14 Sep 2002, Con Kolivas wrote:
> 
> > 
> > I came up with a very simple way of measuring responsiveness that gives
> me
> > numbers that are meaningful to me. What I've done is the old faithful
> kernel
> > compile and measured it under different loads to simulate the pc's ability
> to
> > perform under various loads. I have so far benchmarked 2.4.19 versus
> 2.4.19-ck7,
> >  2.4.19-ck7-rmap and 2.4.18-6mdk(mandrake's kernel in 8.2). 2.5.34 has a
> dead
> > keyboard for me so I'm unable to test it as yet.
> 
> If that's a real kernel compile in <2 minutes I'm impressed!

If you look at my README in the tarball you'll see that I suggest using a
minimal kernel config (ie almost nothing enabled) and include just such a
.config. So, yes, it is a real kernel compile on a 1133Mhz pIII.

Con.
