Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbTIMNpL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 09:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTIMNpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 09:45:11 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:1602 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id S262149AbTIMNpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 09:45:07 -0400
Date: Fri, 12 Sep 2003 17:29:26 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: David Schwartz <davids@webmaster.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Timothy Miller <miller@techsource.com>,
       Pascal Schmidt <der.eremit@email.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: People, not GPL  [was: Re: Driver Model]
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEBNGIAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.44.0309121714540.8729-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, David Schwartz wrote:
|>> On Gwe, 2003-09-12 at 22:47, Matt D. Robinson wrote:
|>> > So include GPL_ONLY(), don't include GPL_ONLY(), whatever.  If you
|>> > don't like it, Mr. Customer, find a Linux distributor that will
|>> > fix the problem for you.
|>
|>> Linux vendors have already recieved, and decided to act on cease and
|>> desist letters involving adding hooks (ie EXPORT_SYMBOL stuff) for non
|>> free modules that were not in the base distro. I think that speaks for
|>> part of the legal view.
|>
|>	Who is sending these letters? Who has no respect for the GPL and seeks to
|>add additional restrictions? IMO, these letters are almost as bad as the SCO
|>letters. Nobody has any business putting additional licensing restrictions
|>on code was placed under the GPL.
|>
|>	DS

FUD, Inc.  If these really did exist, they would be more commonly
known and I'm certain would affect customer choice.  IMHO, I think
this is the vendor's (and I specifically think of Red Hat) way of
excusing themselves from having to work with third party vendors
in order to cover themselves legally with groups like the FSF.
Whether that's true or not, or if there is some other developer
contingent at these distribution houses that is preventing the
EXPORT_SYMBOL{,GPL}() changes due to personal bias, I don't know.
And I doubt we'll ever know.

These letters are like WMD -- they exist, you know they do, but you
just can't find them. :)

--Matt

