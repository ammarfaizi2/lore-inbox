Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSG0Sx2>; Sat, 27 Jul 2002 14:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318803AbSG0Sx2>; Sat, 27 Jul 2002 14:53:28 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:49935 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317751AbSG0Sx1>;
	Sat, 27 Jul 2002 14:53:27 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207271856.g6RIufn63592@saturn.cs.uml.edu>
Subject: Re: Speaker twiddling [was: Re: Panicking in morse code]
To: wowbagger@sktc.net (David D. Hagood)
Date: Sat, 27 Jul 2002 14:56:41 -0400 (EDT)
Cc: arodland@noln.com (Andrew Rodland),
       acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <3D4298C6.9080103@sktc.net> from "David D. Hagood" at Jul 27, 2002 07:57:42 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David D. Hagood writes:

> Either you are trying to output the panic information with minimal 
> hardware, and in a form a human might be able to decode, in which case 
> the Morse option seems to me to be the best, or you are trying to panic 
> in a machine readable format - in which case just dump the data out 
> /dev/ttyS0 and be done with it!
>
> To my way of thinking, the idea of the Morse option is that if an oops 
> happens when you are not expecting it, and you haven't set up any 
> equipment to help you, you still have a shot at getting the data.
>
> Trying to dump the oops data out by some form of FSK in most cases seems 
> silly - if you have taken the time to set up a microphone and decoder, 
> why not just set up a serial terminal?

Reality?

I'm one of the 42 remaining people with a terminal. My VT510
mostly sits unplugged due to heat, and it's taking up space.
The RS-232 port is legacy hardware anyway, due for removal.
My VT510 doesn't speak USB.

Morse doesn't do "<" and other common characters. For those
who know it, morse is useful. For well over 99% of the users,
morse is gibberish anyway.

There's no "set up a microphone and decoder" problem.
Most people have a tape recorder. Use that, then play
back into the PC's sound card after you reboot. Post the
sound file on a web site.

Sure, morse is cute and FSK isn't. FSK is useful. Morse is
useful too, for different reasons. One could output in both
formats, alternating between them until reboot.
