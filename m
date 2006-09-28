Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWI1B3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWI1B3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWI1B3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:29:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32493 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965067AbWI1B3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:29:11 -0400
Subject: Re: GPLv3 Position Statement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chase Venters <chase.venters@clientec.com>, Theodore Tso <tytso@mit.edu>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Sergey Panov <sipan@sipan.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609271641370.3952@g5.osdl.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>
	 <1159319508.16507.15.camel@sipan.sipan.org>
	 <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
	 <1159342569.2653.30.camel@sipan.sipan.org>
	 <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
	 <1159359540.11049.347.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0609271000510.3952@g5.osdl.org>
	 <Pine.LNX.4.64.0609271300130.7316@turbotaz.ourhouse>
	 <20060927225815.GB7469@thunk.org>
	 <Pine.LNX.4.64.0609271808041.7316@turbotaz.ourhouse>
	 <Pine.LNX.4.64.0609271641370.3952@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Sep 2006 02:53:40 +0100
Message-Id: <1159408420.11049.403.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-27 am 17:18 -0700, ysgrifennodd Linus Torvalds:
>      _not_ been unknown to the people involved. Trust me, the FSF knew 
>      very well that the kernel standpoint on the GPLv2 was that Tivo was

s/kernel/Linus and some other copyright holders/

I reserve the right some day to attempt to sue the ass of people who
tivo-ise my code. Hey I might lose but I reserve the right to.

That said the FSF DRM clause is problematic, the GPLv2 leaves things in
a slightly woolly situation with regards to keys in terms of whether
they are part of the scripts etc (for the benefit of anyone's corporate
lawyers: I think they usually are and I've said so in public). That
vagueness is actually a good thing because it lets the legal system
interpret the intent of the license and the situation at hand. Lawyers
generally don't like vaguenesses of course and the GPLv3 draft tries to
be non-vague. It's also flawed as a result precisely because it has to
cover every imaginable case in one paragraph.

There are lots of problems with the current v3 draft

1.	"anything users can regenerate automatically" is horribly vague.
Automatically *how* - with a $25,000 proprietary tool for example ....

2.	Section 3 is US specific and doesn't really work. In some parts of
the world breaking a technological protection seems to be a criminal
matter and you can't waive the criminal law.

3.	Additional terms is a license explosion and the interactions between
them will get ugly.

4.	The geographical clause still has the same bug as GPLv2. Who is the
"original author" and what happens when I write a new OS and import 90%
of Linux into it - am I the original author now ?


Some of this is quite fixable - the "regenerate automatically" for
example and the glitches in the patent clauses are just a matter of a
little more lawyering, others like the DRM clauses don't work and also
don't really address rented equipment for example.

Personally I'm still hopeful the final GPLv3 will fix at least the
majority of problems. I'm not sure it ultimately matters for the kernel
whether it does or not, but for the general case of free software it is
clearly important to get it right.

Alan

