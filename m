Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268233AbUIBK4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268233AbUIBK4t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUIBKyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:54:20 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:2702 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S268243AbUIBKv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:51:59 -0400
X-Sender-Authentication: net64
Date: Thu, 2 Sep 2004 12:51:56 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: kangur@polcom.net, linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040902125156.2dc6fe97.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.58.0408291523130.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
	<412F7D63.4000109@namesys.com>
	<20040827230857.69340aec.pj@sgi.com>
	<20040829150231.GE9471@alias>
	<4132205A.9080505@namesys.com>
	<20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk>
	<20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk>
	<41323751.5000607@namesys.com>
	<20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org>
	<Pine.LNX.4.60.0408300009001.10533@alpha.polcom.net>
	<Pine.LNX.4.58.0408291523130.2295@ppc970.osdl.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 15:37:16 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> [...]
> And even if Linux _these days_ could handle hardlinked directories, the
> fact is that they would cause slightly more memory usage (due to the
> vfsmounts), and that nobody else can handle such filesystems - including
> older versions of Linux. So nobody would likely use the feature (not to
> mention that nobody is even really asking for it ;).

Huh? Me about a year ago ;-)
Been in fact pretty much boo'd for it :-)

I therefore declare as this years hot issue:
How to use more than 32 GIDs on nfs? Frank van Maarseveens' patch being
available for years I guess, but with 2.6 supporting lots of GIDs becoming very
actual...
:-)))
Sorry for being a bit off-topic but shouldn't we first solve the obvious
(broken) and simple issues around fs?

Regards,
Stephan
