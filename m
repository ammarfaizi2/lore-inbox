Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWCMV6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWCMV6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWCMV6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:58:15 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:53008 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S932478AbWCMV6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:58:11 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <bernd@firmix.at>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [future of drivers?] a proposal for binary drivers.
Date: Mon, 13 Mar 2006 13:57:40 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEAJKLAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1142241857.19650.27.camel@tara.firmix.at>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 13 Mar 2006 13:53:54 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 13 Mar 2006 13:53:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Since you got the package from RedHat (or subsidiaries or several people
> in between), you are bound by the GPL since neither RedHat nor the
> several people in between as any different access to the kernel-sources
> than via GPL. And they can't change it.
> So you got it under the rules of the GPL.

	This is a common misconception. The GPL *never* bings the recipient of a
GPL'd work until and unless he agrees to it. You can find this made quite
clear on the FSF's web site.

> > 	4) Copyright does not allow you to own every way to do some
> specific thing,

> Copyright/authors rights allows me to own *my way* of doing it. And if
> you derive your work on mine, it depends on the quality and quantity
> *if* you have any copyright/authors rights on you patch and how the
> joined work must be treated legally.
> In the Linux kernel, dozens (if not hundreds) of people have
> copyrighted/authored righted code in there so.

	The claim here is not that one way to make an NE2000 work with Linux 2.6 is
owned but that *every* way to do that is owned. This is impossible under
copyright. You can certainly own one specific way to make an NE2000 work
with linux 2.6 (that would be a copyrighted driver), but you cannot use
copyright to prevent anyone from implementing a particular function.

> > you need a patent for that. Any application that uses library X or any
> > driver for kernel Y is a specific thing. Copyright only applies
> > when there

> If there was a binary in-kernel API, yes.
> But a) there is no "officially" one and b) we have no "libraries" (in
> the sense of the GPL) here.

	It doesn't matter. You cannot protect a function with copyright. If there
is only one practical way to get a particular function, nobody can use
copyright to own it. Read Lexmark v. Static Controls or goole for "copyright
lock out".

> > are numerous ways to do the same thing or express the same
> > idea. Drivers for
> > different operating systems are different ideas. You cannot use
> > copyright to
> > lock out someone from doing a particular thing, only from doing
> > that thing
> > the same way you did.

> No, you can't even lock someone out to do the same thing. You can only
> lock someone out to base his thing on your thing (but you can't hinder a
> reimplementation - you need a patent for this [and a jurisdiction which
> allows software patents]).

	You cannot lock someone out from basing their think on your thing, if that
is the only practical way to express a particular idea. See Lexmark v.
Static Controls, among other cases.

> > 	6) All of this is copyright law and applies whether or not
> > anyone agrees to
> > the GPL or any other agreement, so nothing those agreements
> > says can change
> > this.

> This is a common misunderstanding: If you change the rules of the GPL,
> you automatically loose all rights you received with the GPL[0]

	Huh? I'm not changing anything. And I'm not talking about any rights
received with the GPL, I'm talking about rights granted by law under first
sale and scenes a faire.

	DS


