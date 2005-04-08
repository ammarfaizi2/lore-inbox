Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVDHGqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVDHGqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVDHGqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:46:40 -0400
Received: from smtp10.wanadoo.fr ([193.252.22.21]:48283 "EHLO
	smtp10.wanadoo.fr") by vger.kernel.org with ESMTP id S262705AbVDHGqM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:46:12 -0400
X-ME-UUID: 20050408064556823.C9062180008B@mwinf1001.wanadoo.fr
Date: Fri, 8 Apr 2005 08:41:52 +0200
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
       Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@lst.de>,
       Ian Campbell <ijc@hellion.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408064152.GB27346@pegasos>
References: <1112689164.3086.100.camel@icampbell-debian> <20050405083217.GA22724@pegasos> <1112690965.3086.107.camel@icampbell-debian> <20050405091144.GA18219@lst.de> <1112693287.6275.30.camel@laptopd505.fenrus.org> <m1wtrfk8w3.fsf@ebiederm.dsl.xmission.com> <20050407112738.GB8508@pegasos> <m1mzsakdws.fsf@ebiederm.dsl.xmission.com> <20050407184241.GA13620@pegasos> <m11x9mge5p.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <m11x9mge5p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 09:06:58PM -0600, Eric W. Biederman wrote:
> Sven Luther <sven.luther@wanadoo.fr> writes:
> 
> > > It sounds like you are now looking at the question of are the
> > > huge string of hex characters the preferred form for making
> > > modifications to firmware.  Personally I would be surprised
> > > but those hunks are small enough it could have been written
> > > in machine code.
> > 
> > Yep, i also think it is in broadcom's best interest to modify the licencing
> > text accordyingly, since i suppose someone could technicaly come after them
> > legally to obtain said source code to this firmware. Unprobable though.
> 
> Possibly.  It sounds like that is what you want to do.

No, i am making them aware of the possibility, and hoping they fix the issue,
but we will see. If they fail to act on this, i don't understand why though,
since it is just addition of a clarification. It is not as if i am asking for
the release of all their chip specs or something such.

> > since there should be at least some kind of executable code in it,
> > independenlty of the fact that we claim that data is also software.
> 
> Do you have any evidence that ``software'' was not written directly in
> machine code?   Software is written directly in machine code when a programmer

So what, i seriously doubt they where written using an vi in C, as the code
currently stands, so we do need an additional level of source code, being it
only some asm code or something.

> looks at the instruction set and writes down the binary representation
> of the instructions.  I know ISC dhcpd has packet filter code that was written
> in that manner, so it is not a lost art.   And it is done often enough when
> an assembler will not cooperate, and generate the correct instruction.

But again, this is not the common assumption, so if this is so, they should
write it down black on white in the copyright notice, and everyone would be
happy.

> Without evidence that we don't have the preferred form of the software
> for making modifications I don't see how you can complain.

No, it goes the other way around. Without evidence that all is clean, we have
no right to distribute that code, and if what you describe was the case, a
couple of lines telling us that fact would solve the issue, and not even need
the involvement of their legal department. I would be somewhat suspisious
though if all these guys came up and said they just wrote said firmware in
binary directly though.

Friendly,

Sven Luther

