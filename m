Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130311AbQLTWde>; Wed, 20 Dec 2000 17:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbQLTWdY>; Wed, 20 Dec 2000 17:33:24 -0500
Received: from mail.inconnect.com ([209.140.64.7]:64448 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S130022AbQLTWdQ>; Wed, 20 Dec 2000 17:33:16 -0500
Date: Wed, 20 Dec 2000 15:02:47 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: iptables: "stateful inspection?"
In-Reply-To: <3A411BC2.1E302455@holly-springs.nc.us>
Message-ID: <Pine.SOL.4.30.0012201455190.20709-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Rothwell said once upon a time (Wed, 20 Dec 2000):

> Alan Cox wrote:
>
> > It does SYN checking. If you are running 'serious' security you wouldnt be
> > allowing outgoing connections anyway. One windows christmascard.exe virus that
> > connects back to an irc server to take input and you are hosed.
>
> Thankfully, pine and mutt are, to date, immune to that kind of thing. :)

Try again.  Pine less than 4.30 has a buffer overflow builtin.  A properly
formated "From" header (or something) can hose you.  No need for any
attachment.

Dax

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
