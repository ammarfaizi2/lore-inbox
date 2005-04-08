Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262669AbVDHDtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbVDHDtV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbVDHDtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:49:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39612 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262669AbVDHDtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:49:14 -0400
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Arjan van de Ven <arjan@infradead.org>, Christoph Hellwig <hch@lst.de>,
       Ian Campbell <ijc@hellion.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       Greg KH <greg@kroah.com>, Michael Poole <mdpoole@troilus.org>,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
References: <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos>
	<1112689164.3086.100.camel@icampbell-debian>
	<20050405083217.GA22724@pegasos>
	<1112690965.3086.107.camel@icampbell-debian>
	<20050405091144.GA18219@lst.de>
	<1112693287.6275.30.camel@laptopd505.fenrus.org>
	<m1wtrfk8w3.fsf@ebiederm.dsl.xmission.com>
	<20050407112738.GB8508@pegasos>
	<m1mzsakdws.fsf@ebiederm.dsl.xmission.com>
	<20050407184241.GA13620@pegasos>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Apr 2005 21:06:58 -0600
In-Reply-To: <20050407184241.GA13620@pegasos>
Message-ID: <m11x9mge5p.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Luther <sven.luther@wanadoo.fr> writes:

> > It sounds like you are now looking at the question of are the
> > huge string of hex characters the preferred form for making
> > modifications to firmware.  Personally I would be surprised
> > but those hunks are small enough it could have been written
> > in machine code.
> 
> Yep, i also think it is in broadcom's best interest to modify the licencing
> text accordyingly, since i suppose someone could technicaly come after them
> legally to obtain said source code to this firmware. Unprobable though.

Possibly.  It sounds like that is what you want to do.
 
> > So I currently have no reason to believe that anything has been
> > done improperly with that code.
> 
> Well, it all depends if you consider this firmware blob as software, which i
> feel it is without doubt, or we have not the same definition of software,
> i.e., the program which runs on the hardware, or not. We cannot claim this is
> data,
> 
> since there should be at least some kind of executable code in it,
> independenlty of the fact that we claim that data is also software.

Do you have any evidence that ``software'' was not written directly in
machine code?   Software is written directly in machine code when a programmer
looks at the instruction set and writes down the binary representation
of the instructions.  I know ISC dhcpd has packet filter code that was written
in that manner, so it is not a lost art.   And it is done often enough when
an assembler will not cooperate, and generate the correct instruction.

Without evidence that we don't have the preferred form of the software
for making modifications I don't see how you can complain.

Eric


