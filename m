Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131730AbQKYUhB>; Sat, 25 Nov 2000 15:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131753AbQKYUgv>; Sat, 25 Nov 2000 15:36:51 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:18926 "EHLO
        brutus.conectiva.com.br") by vger.kernel.org with ESMTP
        id <S131730AbQKYUgm>; Sat, 25 Nov 2000 15:36:42 -0500
Date: Sat, 25 Nov 2000 18:06:31 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andries Brouwer <aeb@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc-2.95.2-51 is buggy
In-Reply-To: <20001125210147.A6798@veritas.com>
Message-ID: <Pine.LNX.4.21.0011251805340.8818-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000, Andries Brouwer wrote:
> On Sat, Nov 25, 2000 at 03:26:15PM -0200, Rik van Riel wrote:
> 
> > The gcc-2.95.2-6cl from Conectiva 6.0 is buggy too.
> 
> Yes. Probably you have seen it by now, but the difference between
> good and bad versions of gcc-2.95.2 did not lie in the applied patches,
> but was the difference between compilation for 686 or 386.
> It is not your (SuSE's, Debian's) fault. A fix already exists.

Indeed, this should be fixed soon.

I'm sure a simple 'apt-get upgrade' will install a new
gcc RPM on my workstation soon ;)

cheers,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
