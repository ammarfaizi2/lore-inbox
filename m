Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbQLFDY6>; Tue, 5 Dec 2000 22:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130746AbQLFDYt>; Tue, 5 Dec 2000 22:24:49 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:2549 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S130507AbQLFDYd>; Tue, 5 Dec 2000 22:24:33 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipchains log will show all flags 
In-Reply-To: Your message of "Tue, 05 Dec 2000 11:00:02 EDT."
             <Pine.LNX.4.30.0012051058090.620-100000@asdf.capslock.lan> 
Date: Wed, 06 Dec 2000 11:40:12 +1100
Message-Id: <20001206004022.B8AAC813F@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.30.0012051058090.620-100000@asdf.capslock.lan> you write
:
> Personally, I'd like to see the rule number stay on the end,and
> have the new display just before it.  The rule number in the
> middle looks messy.

But what will break people's perl scripts?

I think leaving the rule number at the end is probably the Right Thing
from this point of view, so that would be a nice change.

But I prefer the compressed form of `-----' (with the old `SYN' kept
there) to the "SYN FIN RST" alternative.

Cheers,
Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
