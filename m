Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131169AbQLCVUi>; Sun, 3 Dec 2000 16:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131190AbQLCVU3>; Sun, 3 Dec 2000 16:20:29 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:43270 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131169AbQLCVUP>; Sun, 3 Dec 2000 16:20:15 -0500
Date: Sun, 3 Dec 2000 14:45:58 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Steven N. Hirsch" <shirsch@adelphia.net>, linux-kernel@vger.kernel.org
Subject: Re: Phantom PS/2 mouse persists..
Message-ID: <20001203144558.B24353@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.4.21.0012031021580.3253-100000@pii.fast.net> <E142drf-0002yf-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E142drf-0002yf-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Dec 03, 2000 at 06:27:52PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2000 at 06:27:52PM +0000, Alan Cox wrote:
> > Unfortunately, 2.2.18pre24 is still convinced that I have a PS/2 mouse
> > attached to my machine.
> 
> I've fixed the major case. I can see no definitive answer to the other ghost
> PS/2 stuff (except maybe USB interactions). I take it like the others 2.4test
> also misreports a PS/2 mouse being present.
> 
> Anyway I think its no longer a showstopper for 2.2.18. Someone with an affected
> board can piece together the picture


I see it on pre18-23 but pre18-24 seems to be fixed.  I need to test with the 
anaconda installer, since I an still using a pre18-23 boot kernel for 
the install.

Jeff

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
