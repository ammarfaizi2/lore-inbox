Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSFKAkv>; Mon, 10 Jun 2002 20:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316593AbSFKAku>; Mon, 10 Jun 2002 20:40:50 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:40130 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316592AbSFKAku>;
	Mon, 10 Jun 2002 20:40:50 -0400
Date: Mon, 10 Jun 2002 17:40:50 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re : ANN: Linux 2.2 driver compatibility toolkit
Message-ID: <20020610174050.A21783@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote :
> Don't load your drivers up with 2.2.x compatibility junk.  Write a 2.4.x 
> driver... and use this toolkit to make it work under 2.2.

	Actually, wouldn't it be better to have people writting 2.5.X
driver and having your toolkit enabling them for 2.4.X and 2.2.X ?

	Also, have you looked at the Pcmcia package, David Hinds has a
pretty complete compatibility toolkit going back to 1.2.X, and used by
many Pcmcia drivers (it's actually pretty amazing to see all those
Pcmcia drivers working regardless). Maybe you could propose David a
merge of the two (you get some more code and some more userbase).
	Yes, of course, NIH...

	Have fun...

	Jean
