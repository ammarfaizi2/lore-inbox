Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268960AbRG0UhQ>; Fri, 27 Jul 2001 16:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268962AbRG0UhG>; Fri, 27 Jul 2001 16:37:06 -0400
Received: from weta.f00f.org ([203.167.249.89]:390 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S268960AbRG0Ugw>;
	Fri, 27 Jul 2001 16:36:52 -0400
Date: Sat, 28 Jul 2001 08:37:24 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: PEIFFER Pierre <ppeiffer@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A / athlon / MMX
Message-ID: <20010728083724.A1571@weta.f00f.org>
In-Reply-To: <E15QE4v-0006R5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15QE4v-0006R5-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 09:19:21PM +0100, Alan Cox wrote:

    Its heavily tied to certain motherboards. Some people found a
    better PSU fixed it, others that altering memory settings
    helped. And in many cases, taking it back and buying a different
    vendors board worked.

Does anyone know *why* stuff breaks? surely VIA do as they have a fix
for (some, all?) cases of breakage?

My guess is its some kind of timing or near-miss on a signal edge, and
the bios changes relax things so you don't miss whatever it was you
missed before.



  --cw
