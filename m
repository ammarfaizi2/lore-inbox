Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263859AbRFRJaW>; Mon, 18 Jun 2001 05:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263874AbRFRJaM>; Mon, 18 Jun 2001 05:30:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39837 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263859AbRFRJaD>;
	Mon, 18 Jun 2001 05:30:03 -0400
Date: Mon, 18 Jun 2001 05:30:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Flynn <Dave@keston.u-net.com>, rjd@xyzzy.clara.co.uk,
        Bill Pringlemeir <bpringle@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: Newbie idiotic questions.
In-Reply-To: <Pine.LNX.4.33.0106181111210.6596-100000@serv>
Message-ID: <Pine.GSO.4.21.0106180526180.17557-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Jun 2001, Roman Zippel wrote:

> > I wouldn't call it "rather popular".
> 
> You should also grep for '__typeof__'. :-)

Yeeeccchhh. OK, there is more of that. However, the main user of that
beast is, AFAICS, get_user()/put_user() and their ilk in include/asm-*
The rest looks very bogus...

