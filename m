Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVBCFIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVBCFIc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 00:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVBCFIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 00:08:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:1452 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262928AbVBCFHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 00:07:53 -0500
Date: Wed, 2 Feb 2005 21:07:42 -0800
From: Greg KH <greg@kroah.com>
To: Zan Lynx <zlynx@acm.org>
Cc: Pavel Roskin <proski@gnu.org>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Please open sysfs symbols to proprietary modules
Message-ID: <20050203050742.GA17909@kroah.com>
References: <Pine.LNX.4.62.0502021723280.5515@localhost.localdomain> <Pine.LNX.4.50.0502021520200.1538-100000@monsoon.he.net> <20050202232909.GA14607@kroah.com> <Pine.LNX.4.62.0502021851050.19621@localhost.localdomain> <20050203003010.GA15481@kroah.com> <1107406442.23059.16.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107406442.23059.16.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 09:54:02PM -0700, Zan Lynx wrote:
> So, what's the magic amount of redirection and abstraction that cleanses
> the GPLness, hmm?  Who gets to wave the magic wand to say what
> interfaces are GPL-to-non-GPL and which aren't?

Go read the historical posts from Linus that talk about how and why
closed source modules were allowed for Linux.  Then think about the fact
that those issues are no longer pertintante these days for the majority
of people who are trying to create such things.

Then go consult an IP lawyer and listen to what they say.  If your
company feels that it can still ship a closed source driver, with legal
approval, great, you've accepted the risk that this involves, and are
willing to handle the issues that will occur (cease-and-deist letters,
lawsuits, etc.)

> If the trend of making everything _GPL continues, I don't see any choice
> for binary module vendors but to join together to develop a stable
> driver API and build it as a GPL/BSD module.  Do the same API for BSD
> systems to prove modules using it are not GPL derived.  Watch Greg foam.
> It'd be fun.

Ah, UDI is over that-a-way.  Been there, done that, watched everyone
abandon it due to it being a stupid idea.

If you want to revisit it and dig it up and get it working again, more
power to you.  I'll not foam, but laugh.

good luck,

greg k-h
