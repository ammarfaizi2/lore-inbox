Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129429AbQK1AHU>; Mon, 27 Nov 2000 19:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129639AbQK1AHK>; Mon, 27 Nov 2000 19:07:10 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:44548 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S129429AbQK1AG6>; Mon, 27 Nov 2000 19:06:58 -0500
Message-ID: <3A22EF12.4A5D0121@timpanogas.org>
Date: Mon, 27 Nov 2000 16:32:34 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Sven Koch <haegar@cut.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18-23 w/Frame Buffer (LEVEL IV)
In-Reply-To: <Pine.LNX.4.30.0011280012530.22068-100000@space.comunit.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sven Koch wrote:
> 
> On Mon, 27 Nov 2000, Jeff V. Merkey wrote:
> 
> > A level IV issue in 2.2.18-23.  With frame buffer enabled, upon boot,
> > the OS is displaying four penguin images instead of one penguin in the
> > upper left corner of the screen.  Looks rather tacky.  Also puts the VGA
> > text mode default into mode 274.   Is this what's supposed to happen?
> 
> Let me guess: it's a 4 cpu smp system?

Correct.  I take it them this is supposed to happen.

Jeff

> 
> c'ya
> sven
> 
> --
> 
> The Internet treats censorship as a routing problem, and routes around it.
> (John Gilmore on http://www.cygnus.com/~gnu/)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
