Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313860AbSDFBW6>; Fri, 5 Apr 2002 20:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313861AbSDFBWt>; Fri, 5 Apr 2002 20:22:49 -0500
Received: from [151.200.199.53] ([151.200.199.53]:64266 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S313860AbSDFBWk>;
	Fri, 5 Apr 2002 20:22:40 -0500
Message-id: <fc.00858412003a290a00858412003a290a.3a291d@Capaccess.org>
Date: Fri, 05 Apr 2002 20:22:10 -0500
Subject: Forth interpreter as kernel module
To: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two Forths in Linuxspace now? That's 3 stack machines. Heheheheh,




        MAKE YOUR TIME. ALL YOUR BASE ARE BELONG TO KSPAMD.





Does the pforth version run as a kernel daemon like H3rL does?

Phil Burk is I believe still affiliated with Mills College. He'd love to
hear about this. Mike Haas too, probably. Mike Haas wrote the kernel of
Amiga JForth and Phil wrote all the music stuff. I added all the Linux
syscalls to the PForth in cLIeNUX mostly out of nostalgia for JForth, a
"...once in a paradigm thing." Jack "jax" Woehr (sp?). Phil was quite
pleased to hear there's a PForth out there with 160 Linux syscalls as
primitives.

That PForth is in ftp://linux01.gwdg.de/pub/cLIeNUX/interim along with
H3rL, Hohensee's 3-ring Linux, which is a Linux kernel with a 3-stack
machine in 0wnerland. Read ./ABOUT .

Alan,
 an Open Firmware IN kernelspace has the potential to have the
functionality of Open Firmware, AND serve as something like an Open Driver
Initiative, with a performance hit perhaps, depending on how the Forth is
implemented. There are native compiling Forths, but they're not nice tiny
little things.

Ed,
 As far as security is concerned, a Forth on say vt1 (it's on vt1 here,
er, it's H3sm, a 3-stack machine, but anyway...) is no worse really than
root. As far as how a Forth compares to a kdb, it doesn't. Forth is a
debugger, a compiler, an interpreter, AND a desert topping. A forth won't
have the niceties of an evolved unix tool, but you can write them
interactively. And write things you can't imagine until the problem pops
up, like that thing Torvalds did recently for sniffing at some
Torvaldsianly obscure cache tree buffer tree page cache buffer thing. You
can write stuff like that with the same interactivity you associate with
shell scripting.

More to the point, Forth can be a great personalizer of unix/Linux. Sure,
you don't want a Forth in your DNS box. (I do, but...) You do want a Forth
in your multimedia box. Bigtime. Which is why the "forth" command in
cLIeNUX is upforth, PForth with a unix Jones.

If Forth in Linux is going to go somewhere, Mitch Bradley might want to
comment. He's the author of OpenBoot, and I find that some of my best
Forth-on-unix ideas, he had 15 years ago. He left Sun and does Bradley
Forthworks or Forthware, last I heard. Post to comp.lang.forth too.

Rick Hohensee

Birth Of Kspamd reenactment...
imagine each space as *exactly* one second elapsed between string
outputs...

SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM SPAM
SPAM SPAM SPAM SPAM SPAM SPAM SPAM<cursor>



