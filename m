Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129481AbQKMMfo>; Mon, 13 Nov 2000 07:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbQKMMfe>; Mon, 13 Nov 2000 07:35:34 -0500
Received: from ns2.Deuroconsult.ro ([193.226.167.164]:270 "EHLO
	marte.Deuroconsult.ro") by vger.kernel.org with ESMTP
	id <S129481AbQKMMfW>; Mon, 13 Nov 2000 07:35:22 -0500
Date: Mon, 13 Nov 2000 14:35:06 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
To: "Magnus Naeslund(b)" <mag@bahnhof.se>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tracing files that opens.
In-Reply-To: <00c901c04c06$82834690$020a0a0a@totalmef>
Message-ID: <Pine.LNX.4.20.0011131433490.24209-100000@marte.Deuroconsult.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2000, Magnus Naeslund(b) wrote:

> Is there a nice way to trap on file open() and stat() ?
> That way i could have nice file statistics.

Look for a kernel module that replace the open syscall.
I don't have an url right now but search for my name in the lk archives.
I put a question like this.

> 
> Magnus
> 
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
>  Programmer/Networker [|] Magnus Naeslund
>  PGP Key: http://www.genline.nu/mag_pgp.txt
> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

---
Catalin(ux) BOIE
catab@deuroconsult.ro
A new Linux distribution: http://l13plus.deuroconsult.ro
http://www2.deuroconsult.ro/~catab

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
