Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263877AbTDYUir (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTDYUir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:38:47 -0400
Received: from quechua.inka.de ([193.197.184.2]:43403 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263877AbTDYUio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:38:44 -0400
Subject: Re: Flame Linus to a crisp!
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030425191252.GA1853@mail.jlokier.co.uk>
References: <170EBA504C3AD511A3FE00508BB89A9201FD91E8@exnanycmbx4.ipc.com>
	 <20030424212811.GH30082@mail.jlokier.co.uk>
	 <20030425081358.B750C2128A@dungeon.inka.de>
	 <20030425191252.GA1853@mail.jlokier.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1051304168.15158.29.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Apr 2003 22:56:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-25 at 21:12, Jamie Lokier wrote:
> Because the only kernels that ISPs accept connections from are signed
> and encrypted by the computer vendor - which means you _cannot_ trust
> those kernels to not contain back doors.

ah, you want to put apache with mod_ssl into the kernel (now that we
have CONFIG_CRYPTO), including the code to check for client certificates
and the CA certificate itself? You are very welcome to do so, the GPL
allowes this.

Still as you can see, that can also be done in userspace.

Maybe you forget "and I cannot replace the kernel but I want to"?
Now this is not very new: I cannot replace my BIOS either.
Or in fact we could do both, it's merely the same. The hardware
can make it difficult, but still it is a hardware issue, right?

Or maybe you have been fooled by those who propagate that a TCPA
system will on its own create network connections or accept those.

There is no need to: you can do that in userspace a lot easier
than in a tiny hardware chip on a not bus not connected to the
network driver.

I'm a fool, but as fool I say: nothing bad in the kernel or DRM.
All the bad stuff is in the applications, so you can show the kernel,
DRM and TCPA around and claim it is nice and secure and there is
nothing to worry.

But putting bad stuff into applications is something like a tradition
and who would want to break with a tradition like this?

> The question is, if it is widely implemented in available hardware,
> _will_ everyone be using it whether they want to or not?

Maybe it's not such a bad idea to have two computers. One for
entertainment, online banking and digital video rental and stuff
like this where you deal with the paranoid and let them waste their
money on expensive hardware. And one for real work.

Nearly everyone will still provide hardware that works for a general
purpose user that wants to hack, cheat, change hardware, replace cards,
overclock and all that stuff. Or hack on linux 3.1.*.
There is soo much money in it, and companies like earning money.

> Also, what about the law?  Remember, there have been attempts in the
> last year, in the US, to legislate DRM into all computers.

CDBTPA? I read "Argh Anonymous" detailed analysis on cypherpunks,
and I recommend it to you, too. 

www.inet-one.com/cypherpunks/dir.2002.07.15-2002.07.21/msg00225.html

Lots of stuff I read is not based on facts or even on reading the laws,
specs or things like that, but on rumors and nightmares.

That is one of the few sources of someone who seems to have read the TCPA spec
and the CBDTPA law. If you have other sources that also know facts,
please let me know. They seem kind of rare these days.

Regards, Andreas

