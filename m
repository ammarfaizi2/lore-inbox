Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132657AbRAERxa>; Fri, 5 Jan 2001 12:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131389AbRAERxU>; Fri, 5 Jan 2001 12:53:20 -0500
Received: from ns.mmc.ro ([194.102.200.1]:31755 "EHLO ns.mmc.ro")
	by vger.kernel.org with ESMTP id <S129859AbRAERxO>;
	Fri, 5 Jan 2001 12:53:14 -0500
Message-ID: <3A560A6C.D83ABC15@yahoo.com>
Date: Fri, 05 Jan 2001 19:54:52 +0200
From: Catalin <catalin@mmc.ro>
Reply-To: ady982@yahoo.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 Kernel Lockup
In-Reply-To: <JKEGJJAJPOLNIFPAEDHLAEJNCCAA.laramieleavitt@onetel.net.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also have a problem: During booting my screen goes black but after I
login and start X (with a black screen) X works perfectly but if I get out
from X again (in console mode) again I can't see anything (sometimes I can
see a blue or a green screen).
I think is has something to do with the frame buffer options from the
kernel (my previos kernel 2.2.17 worked perfectly with similar
configurations).
I KNOW this is NOT a kernel bug and only a misconfiguration and it is my
fault for this error and I am really sorry if this is not a proper list
for such a question (I just joined this list) but if someone can help me
please do.
I have my kernel configuration list but I can't send it on this list
because is too big (it has 19 kb) but if someone wants to help me I can
send it to his private e-mail address.
Thank you,
Adrian

PS: I have an "vga=791" option in my kernel so my console should be in
1024x768 resolution.
PS(2): I tried using the "voodoo 3" option from the frame buffer menu (I
have a voodoo 3 3000) but then instead of having a black screen I have a
black screen with blue dots that move around (they look like mangnified
distorsioned chars).

Laramie Leavitt wrote:
> 
> I seem to be getting a rather odd kernel lockup on 2.4.
> I am using XFree 3.3.6 ( I believe ).
> 
> Whenever I start X, my session starts up like normal,
> but soon locks HARD.  Is this a known issue?  I
> suspected the fb stuff, and so I removed it and the
> problem remains.
> 
> Any ideas?  I can repeat it every single time.
> 
> Laramie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
