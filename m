Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129689AbQK0Xn4>; Mon, 27 Nov 2000 18:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129744AbQK0Xnr>; Mon, 27 Nov 2000 18:43:47 -0500
Received: from comunit.de ([195.21.213.33]:5428 "HELO comunit.de")
        by vger.kernel.org with SMTP id <S129689AbQK0Xnd>;
        Mon, 27 Nov 2000 18:43:33 -0500
Date: Tue, 28 Nov 2000 00:13:30 +0100 (CET)
From: Sven Koch <haegar@cut.de>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18-23 w/Frame Buffer (LEVEL IV)
In-Reply-To: <3A22E894.4E15E71@timpanogas.org>
Message-ID: <Pine.LNX.4.30.0011280012530.22068-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Jeff V. Merkey wrote:

> A level IV issue in 2.2.18-23.  With frame buffer enabled, upon boot,
> the OS is displaying four penguin images instead of one penguin in the
> upper left corner of the screen.  Looks rather tacky.  Also puts the VGA
> text mode default into mode 274.   Is this what's supposed to happen?

Let me guess: it's a 4 cpu smp system?

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
