Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267650AbRHKOAw>; Sat, 11 Aug 2001 10:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbRHKOAm>; Sat, 11 Aug 2001 10:00:42 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:63506 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267650AbRHKOA1>; Sat, 11 Aug 2001 10:00:27 -0400
X-Apparently-From: <quintaq@yahoo.co.uk>
Date: Sat, 11 Aug 2001 14:59:46 +0100
From: quintaq@yahoo.co.uk
To: <linux-kernel@vger.kernel.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: Errors compiling emu10k1 module under 2.4.8
In-Reply-To: <3B750F77.FAA9A123@eyal.emu.id.au>
In-Reply-To: <20010811101557Z266921-760+224@vger.kernel.org>
	<3B750F77.FAA9A123@eyal.emu.id.au>
Reply-To: quintaq@yahoo.co.uk
X-Mailer: Sylpheed version 0.5.2 (GTK+ 1.2.8; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20010811140032Z267650-760+243@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001 20:56:55 +1000
Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:

> quintaq@yahoo.co.uk wrote:

> Seems that joystick.c wants to be a module by itself, so it cannot be
> linked with the rest of the modules here.
> 
> Removing 'joystick.o' from drivers/sound/emu10k1/Makefile solves the
> compile problem, but I do not know that it is the correct solution.

Thank-you for the quick reply Eyal.  I had just recompiled, when Rui sent
through his patch.

All is working now.

Regards,

Geoff

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

