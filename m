Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262589AbREOAeU>; Mon, 14 May 2001 20:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262590AbREOAeK>; Mon, 14 May 2001 20:34:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16141 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262589AbREOAdz>; Mon, 14 May 2001 20:33:55 -0400
Date: Mon, 14 May 2001 21:33:35 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <viro@math.psu.edu>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E14zPot-0001Sa-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0105142132510.18102-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001, Alan Cox wrote:

> > I've been doubting whether to work on both the -ac kernels
> > and the -linus tree, but this is a pretty good argument for
> > sticking with -ac and just ignoring the -linus tree...
>
> Time will make that decision. Linus kindly gave us all the power
> to vote with our feet. One thing I absolutely refuse to do is to
> let a disagreemnt over some specific device implementation turn
> into an excuse for a wider difference in the trees.

Agreed. However, if this thing means I cannot use the -linus
tree without devfs, then it will also mean my VM stuff only
gets tested on -ac kernels...

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

