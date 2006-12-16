Return-Path: <linux-kernel-owner+w=401wt.eu-S932579AbWLPUXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWLPUXO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWLPUXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:23:14 -0500
Received: from THUNK.ORG ([69.25.196.29]:45105 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932579AbWLPUXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:23:13 -0500
Date: Sat, 16 Dec 2006 15:23:12 -0500
From: Theodore Tso <tytso@mit.edu>
To: Willy Tarreau <w@1wt.eu>
Cc: Linus Torvalds <torvalds@osdl.org>, karderio <karderio@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061216202312.GC1003@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
	Linus Torvalds <torvalds@osdl.org>, karderio <karderio@gmail.com>,
	linux-kernel@vger.kernel.org
References: <1166226982.12721.78.camel@localhost> <Pine.LNX.4.64.0612151615550.3849@woody.osdl.org> <1166236356.12721.142.camel@localhost> <Pine.LNX.4.64.0612151841570.3557@woody.osdl.org> <20061216064344.GF24090@1wt.eu> <20061216144236.GB1003@thunk.org> <20061216163031.GA31013@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216163031.GA31013@1wt.eu>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 05:30:31PM +0100, Willy Tarreau wrote:
> I don't think this is the same case. The film _author_'s primary goal is
> to have a lot of families buy his DVD to watch it. Whatever the MPAA says,
> I can consider it "fair use" if a family of 4..8 persons watch the DVD at
> the same time. 

"You can consider it"?  But you're not the author.  This is the
hypocrisy that Linus was talking about.  At the same time that you're
trying to dictate to other other people can use their copy of the
Linux kernel, when it comes to others people's copyrighted work, you
feel to dictate what is and isn't "fair use".

That's the big thing about dynamic linking.  The GPL has always said
it is about distribution, not about use.  The dynamic linking of a
kernel module happens in the privacy of someone's home.  When we try
to dictate what people are doing in the privacy in their home, we're
no better than the MPAA or the RIAA.  

As far as whether or not someone is allowed to distribute a binary
module that can be linked into the Linux kernel, that's a question of
whether the binary module is a derived work or not.  And that's not up
to us, that's up to the local laws.  But before you decide that you
want the most extreme form of anything that wanders close to one
person's code or header files is a derived work, and to start going to
work lobbying your local legislature, recall that there have been
those who have claimed that Linux is a derived work of Unix because we
used things like #define's for errno codes and structure definitions
of ELF binaries.  You really sure you want to go there?

						- Ted
