Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272244AbRJEVZY>; Fri, 5 Oct 2001 17:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271712AbRJEVZO>; Fri, 5 Oct 2001 17:25:14 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:28546 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S272244AbRJEVZA>; Fri, 5 Oct 2001 17:25:00 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200110052124.WAA20832@mauve.demon.co.uk>
Subject: Re: Odd keyboard related crashes.
To: nikberry@med.umich.edu (Nicholas Berry)
Date: Fri, 5 Oct 2001 22:24:11 +0100 (BST)
Cc: root@mauve.demon.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <sbbd8e9c.095@mail-02.med.umich.edu> from "Nicholas Berry" at Oct 05, 2001 10:42:16 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>> Ian Stirling <root@mauve.demon.co.uk> 10/05/01 05:01AM >>>
> >I'm running 2.4.10, and the ps/2 keyboard came out of it's socket.
> 
> >On plugging back in, all worked fine, until 10 seconds later there was a
> >crash. (the keyboard worked after being plugged in)
> >No oops, just a reboot.
<snip>
> When the keyboard is powered up (or plugged in), it goes through a self =
> test, and reports the status back to the PC. Normally, a start up dialogue =
> takes place between the PC and the keyboard at this point.
> That's fine when you boot your PC, but if you unplug then re-plug the =
> keyboard, the PC will be sent data it's really not expecting, and the BIOS =
> will be very confused.

I should have said.
Both times this happened, the keyboard was working fine after being
plugged in, correctly recognising 30 or so keypresses before the crash.

It happened ~10 seconds after the keyboard was plugged in, with the
system and keyboard remaining functional, with no keyboard related messages
sysloged (remote syslog, so I'm sure), which is why I suspect it may
not be hardware.

