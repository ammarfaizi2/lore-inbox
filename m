Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157331-27300>; Sat, 30 Jan 1999 18:20:14 -0500
Received: by vger.rutgers.edu id <157249-27300>; Sat, 30 Jan 1999 18:19:44 -0500
Received: from snowcrash.cymru.net ([163.164.160.3]:1432 "EHLO snowcrash.cymru.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <157268-27302>; Sat, 30 Jan 1999 18:19:14 -0500
Message-Id: <m106kj0-0007U2C@the-village.bc.nu>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: Strange interrupt behavior in 2.2.0(and pre)
To: linker@z.ml.org (Gregory Maxwell)
Date: Sun, 31 Jan 1999 00:26:52 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, dagb@cs.uit.no, linux-kernel@vger.rutgers.edu, linux-irda@list.uit.no
In-Reply-To: <Pine.LNX.3.96.990130182906.2872C-100000@z.ml.org> from "Gregory Maxwell" at Jan 30, 99 06:30:16 pm
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu

> I believe this is a deliberate feature to keep the device open so that
> other devices cant make /dev/dsp unavailable to esd. (or for the more
> paranoid, it's designed that way to get you to switch all your sound apps
> to ESD).

The current one should be able to avoid that. As I pointed out to the
author the current behaviour is more in incentive not to run ESD in some
cases than anything else.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
