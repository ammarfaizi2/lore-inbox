Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBGH4d>; Wed, 7 Feb 2001 02:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129135AbRBGH4N>; Wed, 7 Feb 2001 02:56:13 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:49404 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129028AbRBGH4B>; Wed, 7 Feb 2001 02:56:01 -0500
Date: Wed, 7 Feb 2001 05:55:45 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Alexander Trotsai <mage@adamant.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Massive speed slowdown with any kernel after 2.4.1
In-Reply-To: <20010207094725.D12250@blackhole.adamant.net>
Message-ID: <Pine.LNX.4.21.0102070555270.1535-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, Alexander Trotsai wrote:

> I have PIII/128Mb/IDE uDMA 66 PC I try 2.4.1ac1, ac2 and
> 2.4.2pre1 And all this kernel after message "Freeing unused
> kernel memmory" highly slowing Even cursor (I have framebuffer)
> blink slowly But

Turn off ACPI

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
