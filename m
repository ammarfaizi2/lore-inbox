Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282006AbRKZSWD>; Mon, 26 Nov 2001 13:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281997AbRKZSVF>; Mon, 26 Nov 2001 13:21:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16391 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282004AbRKZSTN>; Mon, 26 Nov 2001 13:19:13 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] 2.5/2.6/2.7 transition [was Re: Linux 2.4.16-pre1]
Date: 26 Nov 2001 10:18:44 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9tu124$sfi$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111251946400.9764-100000@penguin.transmeta.com> <Pine.LNX.4.33L.0111260857150.4079-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33L.0111260857150.4079-100000@imladris.surriel.com>
By author:    Rik van Riel <riel@conectiva.com.br>
In newsgroup: linux.dev.kernel
>
> On Sun, 25 Nov 2001, Linus Torvalds wrote:
> 
> > The _real_ solution is to make fewer fundamental changes between
> > stable kernels, and that's a real solution that I expect to become
> > more and more realistic as the kernel stabilizes.
> 
> Agreed, this would make a _lot_ of difference in the time it
> takes to get a new stable kernel really stable.
> 

I would REALLY like to see this policy.  I have been harping on this
for some time now -- we have been having 2-3 times too long cycles
between stable kernels, which results in an unacceptable level of
pressure to "get your features in" instead of the proper answer "you
missed the boat, wait for the next one."

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
