Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbVLFTRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbVLFTRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbVLFTRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:17:25 -0500
Received: from thunk.org ([69.25.196.29]:26275 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030195AbVLFTRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:17:24 -0500
Date: Tue, 6 Dec 2005 13:19:19 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <greg@kroah.com>
Cc: Tim Bird <tim.bird@am.sony.com>, David Woodhouse <dwmw2@infradead.org>,
       arjan@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206181919.GA19905@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Greg KH <greg@kroah.com>,
	Tim Bird <tim.bird@am.sony.com>,
	David Woodhouse <dwmw2@infradead.org>, arjan@infradead.org,
	andrew@walrond.org, linux-kernel@vger.kernel.org
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512051826.06703.andrew@walrond.org> <1133817575.11280.18.camel@localhost.localdomain> <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com> <20051206041215.GC26602@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206041215.GC26602@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 08:12:16PM -0800, Greg KH wrote:
> On Mon, Dec 05, 2005 at 03:56:06PM -0800, Tim Bird wrote:
> > DISCLAIMER: I'm not speaking for Sony here. Personally
> > I don't believe that most drivers are derivative works
> > of the operating systems they run with, and I don't
> > believe it helps Linux to assert that they are.
> > But, hey, it's not my kernel, and not my plan for
> > world domination. ;-)
> 
> Why do people bring up the "derivative works" issue all the time.  Are
> they so blind to the very simple "linking" issue that all kernel modules
> do when they are loaded into the kernel?

The linked kernel+module combination is pretty clearly a derived work
(but I am not a lawyer).  However, that never gets *distributed* and
the GPL only covers distribution rights.

The question of whether or not something which *could* be linked into
the kernel is a derived work is a very different question, and if
taken too far, an advocate of this interpretation starts advocating
something very close to interface copyrights --- something which I
will note the FSF is passionately against when they called a boycott
on companies such as Lotus many years ago.

But this is very much off-topic for this list.  I suggest that folks
talk to Larry Rosen for his view on this issue, if they want a
balanced counterpoint to that pushed by the FSF.

							- Ted
