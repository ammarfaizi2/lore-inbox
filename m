Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSECIWj>; Fri, 3 May 2002 04:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315601AbSECIVF>; Fri, 3 May 2002 04:21:05 -0400
Received: from [195.39.17.254] ([195.39.17.254]:24723 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315598AbSECIUD>;
	Fri, 3 May 2002 04:20:03 -0400
Date: Fri, 3 May 2002 00:57:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020502225743.GC22246@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0205020913390.32217-100000@chaos.physics.uiowa.edu> <E173IMG-00047l-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > possible that the ABI does not change but the checksum does. That happens 
> > a lot, but it's not really a big problem because that (if done right) will 
> > just cause spurious rebuilds - correctness isn't affected.
> 
> ccache is your friend on that one.
> 
> > Of course, for people who are patching their kernels a lot, modversions
> > (again if done right) are a pain in the a**, since they cause a lot of not
> > really necessary rebuilds. But people who do that supposedly think they
> 
> ccache is still your friend 8)

What is ccache?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
