Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289024AbSA3JpQ>; Wed, 30 Jan 2002 04:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289021AbSA3JpG>; Wed, 30 Jan 2002 04:45:06 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28367 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289022AbSA3Jo5>;
	Wed, 30 Jan 2002 04:44:57 -0500
Date: Wed, 30 Jan 2002 04:44:55 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Chris Ricker <kaboom@gatech.edu>,
        World Domination Now! <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130044455.C11267@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0201291719070.24557-100000@verdande.oobleck.net> <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com> <20020130091912.A16937@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130091912.A16937@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Jan 30, 2002 at 09:19:12AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 09:19:12AM +0000, Russell King wrote:
> On Tue, Jan 29, 2002 at 04:44:12PM -0800, Linus Torvalds wrote:
> > I have to admit that personally I've always found the MAINTAINERS file
> > more of an irritation than anything else. The first place _I_ tend to look
> > personally is actually in the source files themselves (although that may
> > be a false statistic - the kind of people I tend to have to look up aren't
> > the main maintainers at all, but more single driver people etc).
> > 
> > It might not be a bad idea to just make that "mention maintainer at the
> > top of the file" the common case.
> 
> There's one problem with that though - if someone maintains many files,
> and his email address changes, you end up with a large patch changing all
> those email addresses in every file.
> 
> IMHO its far better to have someone's name at the top of each file, and
> put the email addresses in the MAINTAINERS file.

Also FWIW I go to MAINTAINERS file first, when I construct the CC line
for patches sent to Linus.  Poking around the source is annoying and not
terribly scalable in my experience.

	Jeff



