Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130671AbQLKU6O>; Mon, 11 Dec 2000 15:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130632AbQLKU6E>; Mon, 11 Dec 2000 15:58:04 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:24307 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130671AbQLKU5w>; Mon, 11 Dec 2000 15:57:52 -0500
Date: Mon, 11 Dec 2000 18:23:36 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John Fremlin <vii@penguinpowered.com>, scole@lanl.gov,
        linux-kernel@vger.kernel.org
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <E145Xy6-0008HA-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012111823150.4808-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, Alan Cox wrote:

> > Doing a 'make bzImage' is NOT VM-intensive. Using this as a test
> > for the VM doesn't make any sense since it doesn't really excercise
> > the VM in any way...
> 
> Its an interesting demo that 2.4 has some performance problems
> since 2.2 is slower than 2.0 although nowdays not much.

Indeed, but blaming the VM subsystem for something which hardly
touches the VM is a tad strange ...

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
