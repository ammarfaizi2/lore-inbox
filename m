Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSKRHRH>; Mon, 18 Nov 2002 02:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSKRHRH>; Mon, 18 Nov 2002 02:17:07 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:55184 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261574AbSKRHRG>; Mon, 18 Nov 2002 02:17:06 -0500
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay>
	<ar3op8$f20$1@penguin.transmeta.com>
	<20021115222430.GA1877@tahoe.alcove-fr>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 18 Nov 2002 16:20:47 +0900
In-Reply-To: <20021115222430.GA1877@tahoe.alcove-fr>
Message-ID: <buolm3rpcmo.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop <stelian.pop@fr.alcove.com> writes:
> Using USB instead of the serial line or the network card would be
> the best IMHO, because:
> 
> 	* many machines have network cards, but all machines have USB
> 	  (and it's gonna stay this way for some time)

Um, no; _many_ machines have USB.

[The boards I work with all have a UART _on the CPU chip_, so it's
pretty cheap to give them a serial connection, and many of them have a
network connection because it's needed -- but none of them have USB...

Even if you're talking about just PCs, most of the PCs I use are
slightly old, and don't have USB; maybe I'm just from mars or something,
but it's always kind of annoying to see people talking as if USB were
universal...]

-Miles
-- 
80% of success is just showing up.  --Woody Allen
