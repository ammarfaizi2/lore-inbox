Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131739AbQLNTCt>; Thu, 14 Dec 2000 14:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132383AbQLNTCj>; Thu, 14 Dec 2000 14:02:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4612 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131739AbQLNTCd>; Thu, 14 Dec 2000 14:02:33 -0500
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
To: sabre@nondot.org (Chris Lattner)
Date: Thu, 14 Dec 2000 18:34:07 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), viro@math.psu.edu (Alexander Viro),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012141135100.26708-100000@www.nondot.org> from "Chris Lattner" at Dec 14, 2000 11:37:11 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146dCi-00008y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But alan, that's the beautiful thing.  Given a CORBA object, you can
> understand its structure without knowing exactly what the contents
> are.  You can effectively derive it's prototype just by inspecting it.

Oh dear this isnt going in is it. 

Look I know the prototype of every single lisp transaction - its a list. Period.
I know how to manipulate any data I have and print it, because its a list.
I know how to extend it, because its .. a list.

If I need to put content identification in, well guess what - thats a list

	((my_name "Hello") (his_name "Foo"))

and XML is simply lisp done wrong.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
