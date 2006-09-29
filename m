Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161406AbWI2V0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161406AbWI2V0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161419AbWI2V0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:26:23 -0400
Received: from thunk.org ([69.25.196.29]:17126 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1161406AbWI2V0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:26:21 -0400
Date: Fri, 29 Sep 2006 17:25:53 -0400
From: Theodore Tso <tytso@mit.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Helge Hafting <helge.hafting@aitel.hist.no>, tglx@linutronix.de,
       Neil Brown <neilb@suse.de>, Michiel de Boer <x@rebelhomicide.demon.nl>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
Message-ID: <20060929212553.GB11017@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Helge Hafting <helge.hafting@aitel.hist.no>, tglx@linutronix.de,
	Neil Brown <neilb@suse.de>,
	Michiel de Boer <x@rebelhomicide.demon.nl>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <17687.46268.156413.352299@cse.unsw.edu.au> <1159183895.11049.56.camel@localhost.localdomain> <1159200620.9326.447.camel@localhost.localdomain> <451CF22D.4030405@aitel.hist.no> <Pine.LNX.4.64.0609290940480.3952@g5.osdl.org> <1159552021.13029.58.camel@localhost.localdomain> <Pine.LNX.4.64.0609291030050.3952@g5.osdl.org> <1159554375.13029.67.camel@localhost.localdomain> <Pine.LNX.4.64.0609291120440.3952@g5.osdl.org> <Pine.LNX.4.64.0609291131300.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609291131300.3952@g5.osdl.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the things which I'm fond of pointing out is that all of the
freedoms people would have to hack MacOS, especially MacOS 9, where
all of the various "Mac Extensions" which changed and extended the UI
of the Macintosh, would have completely disappeared if the FSF's idea
of "derived works" was in fact the law of the land.  That's because
(a) Apple hated the fact that people dared to think that the UI has
handed down on the stone tablets inscribed by Steve Jobs could be
improved upon, and (b) the way those changes were made by patching
jump tables so that code to extend the UI could be patched into the OS
--- in effect, a dynamic link.

Now, because Apple hated the fact that people dared to think they
could improve on Apple's UI design, they frequently changed the jump
table interfaces, forcing the people who wrote the "Mac Hacks" to
follow a rapidly changing code stream --- much like what the Linux
kernel does with its device driver interfaces.  But Apple has *never*
said that just because you dynamically link with MacOS, that instantly
makes your MacOS a derived work, and so therefore as the copyright
holder of MacOS, Apple could therefore have the right to control how,
or even whether or not the Macintosh Extensions could ever exist.

Thanks goodness, no sane court has ever ruled that the various
Macintosh Extensions were a derived work, just because they lived in
the same address space as MacOS and dynamically linked with MacOS, and
in fact were **designed** only to work with MacOS, and very often used
header files shipped by the Macintosh Programmer's Workbench.

So don't be too quick to wish that the courts will use the FSF's pet
definition of what derived works mean ---- you may find that in the
end, you end up losing far more freedoms than you expect.

						- Ted
