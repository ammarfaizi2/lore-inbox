Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbVLFUxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbVLFUxW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVLFUxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:53:22 -0500
Received: from thunk.org ([69.25.196.29]:50341 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932624AbVLFUxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:53:21 -0500
Date: Tue, 6 Dec 2005 15:53:06 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Tim Bird <tim.bird@am.sony.com>,
       David Woodhouse <dwmw2@infradead.org>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206205306.GA23408@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
	Tim Bird <tim.bird@am.sony.com>,
	David Woodhouse <dwmw2@infradead.org>, arjan@infradead.org,
	andrew@walrond.org, linux-kernel@vger.kernel.org
References: <200512051826.06703.andrew@walrond.org> <1133817575.11280.18.camel@localhost.localdomain> <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com> <20051206041215.GC26602@kroah.com> <20051206181919.GA19905@thunk.org> <1133897262.23610.36.camel@localhost.localdomain> <20051206193801.GC19905@thunk.org> <1133900307.23610.70.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133900307.23610.70.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 08:18:27PM +0000, Alan Cox wrote:
> On Maw, 2005-12-06 at 14:38 -0500, Theodore Ts'o wrote:
> > Conspiracy to commit what offence?  There's nothing wrong with linking
> > GPL'ed code with propietary code, in the privacy of your own home (or
> > server).  The offence only happens when you distribute the resulting
> > derived work....
> 
> In many countries moving the data from hard disk to memory is copying,
> ditto to cache, and that is established caselaw.

Ah, but the GPL hangs its requirements off of "distribution", not
copying per se.  Also note the following statement from the GPL:

	"The act of running the Program is not restricted"

But this is not legal advice, and I am not a lawyer; anyone who is
wants to figure out what they can or can't do shouldn't be talking to
either Alan or me; they should be talking to a real, live lawyer.

							- Ted
