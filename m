Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRCUTPh>; Wed, 21 Mar 2001 14:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131742AbRCUTP2>; Wed, 21 Mar 2001 14:15:28 -0500
Received: from clueserver.org ([206.163.47.224]:31496 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S131736AbRCUTPO>;
	Wed, 21 Mar 2001 14:15:14 -0500
Date: Wed, 21 Mar 2001 11:28:12 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: mysterious card
In-Reply-To: <27525795B28BD311B28D00500481B7601F104E@ftrs1.intranet.ftr.nl>
Message-ID: <Pine.LNX.4.10.10103211126060.18756-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Heusden, Folkert van wrote:

> Hi,
> 
> I have this mysterious 8 bit ISA card with nothing more then 2 smb-mounted
> ic's
> and a button. It seems to be something that should force a system memory
> dump.
> I think I can handle the code-writing, but since there's no documentation I
> have
> to find out how things are working.
> Ok, the question is: does anyone know a place on the web where I can find
> specifications of ISA-slots? I need to know what is supposed to be connected
> to
> the pins (1, 2, 6, etc.)

It is supposed to do that!

That sounds like the card that came with an old DOS debugger.

The old 8088 PCs did not have a reset switch. This was so you could do
hardware breaks when the whole system was locked up.

I have one of those lying around somewhere...

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

