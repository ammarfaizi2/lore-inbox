Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbTDYViP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbTDYViN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:38:13 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:41864 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264511AbTDYViF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:38:05 -0400
Date: Fri, 25 Apr 2003 22:50:14 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030425215014.GA2132@mail.jlokier.co.uk>
References: <170EBA504C3AD511A3FE00508BB89A9201FD91E8@exnanycmbx4.ipc.com> <20030424212811.GH30082@mail.jlokier.co.uk> <20030425081358.B750C2128A@dungeon.inka.de> <20030425191252.GA1853@mail.jlokier.co.uk> <1051304168.15158.29.camel@simulacron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051304168.15158.29.camel@simulacron>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus wrote:
> On Fri, 2003-04-25 at 21:12, Jamie Lokier wrote:
> > Because the only kernels that ISPs accept connections from are signed
> > and encrypted by the computer vendor - which means you _cannot_ trust
> > those kernels to not contain back doors.
> 
> ah, you want to put apache with mod_ssl into the kernel (now that we
> have CONFIG_CRYPTO), including the code to check for client certificates
> and the CA certificate itself? You are very welcome to do so, the GPL
> allowes this.
> 
> Still as you can see, that can also be done in userspace.

Eh?  The chain of trust can be extended to userspace too.

> Maybe you forget "and I cannot replace the kernel but I want to"?
> Now this is not very new: I cannot replace my BIOS either.
> Or in fact we could do both, it's merely the same. The hardware
> can make it difficult, but still it is a hardware issue, right?

Indeed, and I enjoy reverse engineering :)

I don't enjoy reverse engineering encryption chips with embedded keys
though.  That's out of my economic reach, not to mention that much as
I love the idea of being arse-raped daily (i.e. in prison) I don't
fancy the diseases that come with it, nor the shitty dinner menu.

> Maybe it's not such a bad idea to have two computers. One for
> entertainment, online banking and digital video rental and stuff
> like this where you deal with the paranoid and let them waste their
> money on expensive hardware. And one for real work.

Just like we have to have two computers now - one to exchange
documents with other people (Windows + Office) - another to do real
work?

Sounds great...  um.

(Ok, ok, Office isn't such a big deal any more.  (Although even now I
have Word docs that don't work in Openoffice, KOffice or Abiword)).

Ok, I relent.  I suppose it _is_ reasonable that I have one computer I
can run my choice of programs on and a different one that is capable
of connecting to the 2010 Internet.

> CDBTPA? I read "Argh Anonymous" detailed analysis on cypherpunks,
> and I recommend it to you, too. 
> 
> www.inet-one.com/cypherpunks/dir.2002.07.15-2002.07.21/msg00225.html

Thanks for the link.  Sadly the article seems to have gone missing :)

> If you have other sources that also know facts,
> please let me know. They seem kind of rare these days.

Fair point.

I speak about what this stuff _could_ be used for, as a general
warning to be diligent, rather than what is planned right now.

-- Jamie
