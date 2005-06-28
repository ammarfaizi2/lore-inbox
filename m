Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVF1JsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVF1JsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVF1JsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:48:18 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18951 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262029AbVF1JsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:48:14 -0400
Date: Tue, 28 Jun 2005 11:48:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Hans Reiser <reiser@namesys.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Markus T?rnqvist <mjt@nysv.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       David Masover <ninja@slaphack.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>, Steve Lord <lord@xfs.org>
Subject: Re: reiser4 merging action list
Message-ID: <20050628094809.GQ3629@stusta.de>
References: <42BB7B32.4010100@slaphack.com> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl> <20050627092138.GD11013@nysv.org> <20050627124255.GB6280@thunk.org> <42C0578F.7030608@namesys.com> <20050627212628.GB27805@thunk.org> <42C084F1.70607@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C084F1.70607@namesys.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 04:00:01PM -0700, Hans Reiser wrote:
> 
> Andrew asked me to put together a list of things that need to be done
> before merging:
>...
> Probably I forget something.


  * remove the dependency on !4KSTACKS


> Best,
> 
> Hans

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

