Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261980AbTCHBRr>; Fri, 7 Mar 2003 20:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbTCHBRq>; Fri, 7 Mar 2003 20:17:46 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:13068 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261980AbTCHBRU>; Fri, 7 Mar 2003 20:17:20 -0500
Date: Sat, 8 Mar 2003 02:27:45 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <3E693D65.8060308@zytor.com>
Message-ID: <Pine.LNX.4.44.0303080208340.32518-100000@serv>
References: <Pine.LNX.4.44.0303072121180.5042-100000@serv>
 <Pine.LNX.4.44.0303071459260.1309-100000@home.transmeta.com>
 <20030307233916.Q17492@flint.arm.linux.org.uk> <3E692EE4.9020905@zytor.com>
 <Pine.LNX.4.44.0303080116500.32518-100000@serv> <3E693D65.8060308@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Mar 2003, H. Peter Anvin wrote:

> a) I, as well as the other early userspace developers, feel that the
> advantages of allowing linking nonfree applications outweigh the
> disadvantages.

This is also possible with the GPL, see libgcc. What advantage has your 
license to offer?

> b) I will personally go batty if I ever have to create yet another
> implementation of printf() and the few other things in klibc that is
> anything other than a thin shim over the kernel interface.  The bottom
> line is that klibc is so Linux-specific, that the only way someone would
> "steal" code from it is because they want a specific subroutine
> somewhere, and as far as I'm concerned, they can have it, and I don't
> care in the slightest for what project.

Why do you make this decision for everyone?
If I wanted to use *BSD I would use it. The point of using Linux and 
the GPL is that we at least attempt to protect the source to keep it free 
and any contribution should be given the same respect. You insist on using 
a different license, which would set a precedence with until now unknown 
consequences. Your indifference in this matter is very alarming and 
provokes only that klibc is very quickly replaced with yet another libc 
implementation.

bye, Roman

