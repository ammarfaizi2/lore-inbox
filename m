Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289054AbSA3KTR>; Wed, 30 Jan 2002 05:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289058AbSA3KTH>; Wed, 30 Jan 2002 05:19:07 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:49871 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289054AbSA3KS5>;
	Wed, 30 Jan 2002 05:18:57 -0500
Date: Wed, 30 Jan 2002 05:18:55 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>, mingo@elte.hu,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130051855.E11267@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.33.0201300110420.1542-100000@penguin.transmeta.com> <E16VrdT-0006t7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16VrdT-0006t7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 30, 2002 at 10:06:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 10:06:35AM +0000, Alan Cox wrote:
> The other related question is device driver implementation stuff (not interfaces
> and abstractions). You don't seem to check that much anyway, or have any taste
> in device drivers 8) so should that be part of the small fixing job ?

I've often dreamt of an overall "drivers maintainer" or perhaps just an
unmaintained-drivers maintainer:  a person with taste who could give
driver patches a glance, when noone else does.
(and no I'm not volunteering :))

	Jeff, dreams on



