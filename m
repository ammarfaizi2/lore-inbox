Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbTIMWbp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbTIMWbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:31:45 -0400
Received: from mail.webmaster.com ([216.152.64.131]:61595 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262243AbTIMWaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:30:39 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Pascal Schmidt" <der.eremit@email.de>,
       "Andre Hedrick" <andre@linux-ide.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: People, not GPL  [was: Re: Driver Model]
Date: Sat, 13 Sep 2003 15:30:35 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKMEGJGIAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1063490941.9402.14.camel@dhcp23.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sad, 2003-09-13 at 22:19, David Schwartz wrote:

> > > If people put GPL_ONLY symbol exports in their code, that's their call
> > > to make, is it not? It's their code and they're free to say
> > > "well, this
> > > is my code, and if you use this symbol, I consider your stuff to be a
> > > derived work". Once again it's up to the lawyers to decide whether
> > > this has legal value or not.

> > 	If it has legal value, then it's an additional restriction.

> If it has legal value in showing the work is derivative thats not an
> additional restriction.

	If the work would not have been restricted without it and is restricted
with it and you can't remove it, it's an additional restriction. If not,
what would an additional restriction be?

> Its merely showing the intent of the author.

	The intent of the author has no bearing on whether or not a work is
derived.

> If
> someone creates a work and its found to be derivative and they didnt
> make it GPL compatible they get sued, thats also not an additional
> restriction its what the GPL says anyway.

	Show me where the GPL says you have to GPL derived works that you don't
distribute. That restriction is found nowhere in the GPL and if you
attempted to impose such a restriction, it would be an additional one.

> That is the whole point of EXPORT_SYMBOL_GPL, it doesn't enforce
> anything and Linus was absolutely specific it should not do the
> enforcing. Its a hint and a support filter.

	If it doesn't enforce anything and isn't a license restriction, then it's
perfectly legal and kosher to remove it.

	DS


