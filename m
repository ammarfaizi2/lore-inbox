Return-Path: <linux-kernel-owner+w=401wt.eu-S1750705AbWLOF3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWLOF3J (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 00:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWLOF3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 00:29:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbWLOF3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 00:29:06 -0500
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Scott Preece <sepreece@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       Eric Sandeen <sandeen@sandeen.net>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
References: <20061214003246.GA12162@suse.de> <20061214005532.GA12790@suse.de>
	<Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
	<458171C1.3070400@garzik.org>
	<Pine.LNX.4.64.0612140855250.5718@woody.osdl.org>
	<20061214170841.GA11196@tuatara.stupidest.org>
	<20061214173827.GC3452@infradead.org>
	<20061214175253.GB12498@tuatara.stupidest.org>
	<458194B8.1090309@sandeen.net>
	<20061214183956.GA13692@tuatara.stupidest.org>
	<7b69d1470612141142k63cc7d11l89c0a7f26acc631a@mail.gmail.com>
	<4581A75C.9020509@wolfmountaingroup.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Fri, 15 Dec 2006 03:28:00 -0200
In-Reply-To: <4581A75C.9020509@wolfmountaingroup.com> (Jeff V. Merkey's message of "Thu\, 14 Dec 2006 12\:34\:52 -0700")
Message-ID: <orodq53ezj.fsf@redhat.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 14, 2006, "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> wrote:

> FREE implies a transfer of ownsership

It's about freedom, not price.  And even then, it's the license that
has not cost, not the copyright.

> and you also have to contend with the Doctrine of Estoppel.  i.e. if
> someone has been using the code for over two years, and you have not
> brought a cause of action, you are BARRED from doing so under the
> Doctrine of Estoppel and statute of limitations.

Sure, but we're not necessarily talking about code that is two years
old.  We're talking about future releases.  Then, if someone
interfaces with code that was already there before, they might claim
they're still entitled to do so.  But if it's new code they interface
with, or new code they wrote after this clarification is published,
would they still be entitled to estoppel?  FWIW, IANAL.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
FSF Latin America Board Member         http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
