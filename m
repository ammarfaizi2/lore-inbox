Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317941AbSFNP4f>; Fri, 14 Jun 2002 11:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317942AbSFNP4e>; Fri, 14 Jun 2002 11:56:34 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:10491 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317941AbSFNP4d>; Fri, 14 Jun 2002 11:56:33 -0400
Date: Fri, 14 Jun 2002 11:56:34 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020614115634.B22888@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D09F769.8090704@evision-ventures.com> <20020614151703.GB1120@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 05:17:03PM +0200, Jens Axboe wrote:
> And finally a small plea for more testing. Do you even test before
> blindly sending patches off to Linus?! Sometimes just watching how
> quickly these big patches appears makes it impossible that they have
> gotten any kind of testing other than the 'hey it compiles', which I
> think it just way too little for something that could possible screw
> peoples data up very badly. Frankly, _I'm_ too scared to run 2.5 IDE
> currently. The success ratio of posted over working patches is too big.

Add my voice to these concerns.  At the very least the code should have 
been moved into a second tree to allow people to work with the old stable 
driver as needed.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
