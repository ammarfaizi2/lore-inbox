Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287940AbSA3BkO>; Tue, 29 Jan 2002 20:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287894AbSA3BkF>; Tue, 29 Jan 2002 20:40:05 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:25865 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287880AbSA3Bjr>; Tue, 29 Jan 2002 20:39:47 -0500
Subject: Re: A modest proposal -- We need a patch penguin
From: Miles Lane <miles@megapathdsl.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Chris Ricker <kaboom@gatech.edu>,
        World Domination Now!
	 <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201291641090.1747-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 29 Jan 2002 17:38:11 -0800
Message-Id: <1012354692.1777.4.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-29 at 16:44, Linus Torvalds wrote:
> 
> On Tue, 29 Jan 2002, Chris Ricker wrote:
> >
> > That's fine, but there's a major problem with your scheme.  What happens
> > with all the stuff for which no one is listed in MAINTAINERS?
> 
> I have to admit that personally I've always found the MAINTAINERS file
> more of an irritation than anything else. The first place _I_ tend to look
> personally is actually in the source files themselves (although that may
> be a false statistic - the kind of people I tend to have to look up aren't
> the main maintainers at all, but more single driver people etc).
> 
> It might not be a bad idea to just make that "mention maintainer at the
> top of the file" the common case.

I do similarly when I am testing Gnome software, but there
I have the CVS sources to look at, including carefully updated
ChangeLog files.  I find the ChangeLogs and the output of
"cvs log ChangeLog" to be highly informative and helpful when
attempting to track down the appropriate person to contact.
Is it feasible to set up a read-only anonymous cvs server for
the kernel tree?  It seems to me that it would be nice to 
good to have ChangeLogs for the kernel directories as well.

	Miles

