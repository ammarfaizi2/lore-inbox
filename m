Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280743AbRKYGfY>; Sun, 25 Nov 2001 01:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280740AbRKYGfE>; Sun, 25 Nov 2001 01:35:04 -0500
Received: from theirongiant.weebeastie.net ([203.62.148.50]:40325 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S280738AbRKYGfB>; Sun, 25 Nov 2001 01:35:01 -0500
Date: Sun, 25 Nov 2001 17:34:29 +1100
From: CaT <cat@zip.com.au>
To: John Alvord <jalvo@mbay.net>
Cc: David Relson <relson@osagesoftware.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Releases
Message-ID: <20011125173429.C662@zip.com.au>
In-Reply-To: <4.3.2.7.2.20011124231412.00b40c50@mail.osagesoftware.com> <Pine.LNX.4.20.0111242147500.26049-100000@otter.mbay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20.0111242147500.26049-100000@otter.mbay.net>
User-Agent: Mutt/1.3.23i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 09:49:39PM -0800, John Alvord wrote:
> Development kernels are development kernels... nothing else. Look to
> distributors for high degrees of quality assurance testing. When you run a
> development kernel you have joined the development team, even if you don't
> know it. Finding  and reporting bugs is your job...

2.x.y, where x is even, is not a development kernel. It's a release kernel.
2.x.y, where x is odd is a development kernel
2.x.yprez is a development kernel

I think his point is that recently, 2.x.y where x is even has been of
the same quality as a development kernel. Blatantly nasty bugs are in it
and they really shouldn't be. And so, in order to test things out better
he effectively saying that putting a -rcz tag on it will help as it'll
indicate a release candidate and as such might get more ppl to use it.
Once no obvious issues show up with those, put it as a release.

No real extra work required. You just need to make a decision of 'enough
stuffing about. I wanna make a release soon' and start labelling
acordingly. This doesn't mean -rcz will be release quality. It just
means that it's close to it. It still wont mean it's 100% bug free but
it's an extra chance to catch the bad stuff.

All in all, it's not a bad idea[tm].

-- 
CaT        "As you can expect it's really affecting my sex life. I can't help
           it. Each time my wife initiates sex, these ejaculating hippos keep
           floating through my mind."
                - Mohd. Binatang bin Goncang, Singapore Zoological Gardens
