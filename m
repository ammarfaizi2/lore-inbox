Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315606AbSE2Wii>; Wed, 29 May 2002 18:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315611AbSE2Wih>; Wed, 29 May 2002 18:38:37 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:10907
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S315606AbSE2Wih>; Wed, 29 May 2002 18:38:37 -0400
Date: Wed, 29 May 2002 18:38:27 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Paul P Komkoff Jr <i@stingr.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.19 - What's up with the kernel build?
In-Reply-To: <3CF540F8.6000802@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0205291827130.23147-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2002, Jeff Garzik wrote:

> Well, I really like Keith's kbuild25 too, but Linus said (at least once) 
> he wanted an evolution to a new build system... not an unreasonable 
> request to at least consider.  Despite Keith's quality of code (again -- 
> I like kbuild25), his 3 patch submissions seemed a lot like ultimatums, 
> very "take it or leave it dammit".  Not the best way to win friends and 
> influence people.
> 
> If Keith is indeed leaving it, I'm hoping someone will maintain it, or 
> work with Kai to integrate it into 2.5.x.

When I suggested to Keith he push kbuild25 the way Linus likes, he (Keith) 
considered that was a "stupid comment" and that he'd ignore stupid comments.

So it looks like someone else will have to volunteer to split kbuild25 into
multiple small patches and feed them "piecemeal" to Linus before we ever see
it into the kernel tree.


Nicolas

