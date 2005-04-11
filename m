Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVDKQKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVDKQKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVDKQJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:09:43 -0400
Received: from mail.enyo.de ([212.9.189.167]:35205 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261826AbVDKQGD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:06:03 -0400
From: Florian Weimer <fw@deneb.enyo.de>
To: Petr Baudis <pasky@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
References: <20050410184522.GA5902@pasky.ji.cz>
	<Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
	<20050410222737.GC5902@pasky.ji.cz>
	<Pine.LNX.4.58.0504101557180.1267@ppc970.osdl.org>
	<20050410232637.GC18661@pasky.ji.cz>
	<Pine.LNX.4.58.0504101639130.1267@ppc970.osdl.org>
	<20050410235617.GE18661@pasky.ji.cz>
	<Pine.LNX.4.58.0504101716420.1267@ppc970.osdl.org>
	<20050411074523.GB5485@elte.hu> <871x9hemfz.fsf@deneb.enyo.de>
	<20050411105211.GA28484@pasky.ji.cz>
Date: Mon, 11 Apr 2005 18:05:56 +0200
In-Reply-To: <20050411105211.GA28484@pasky.ji.cz> (Petr Baudis's message of
	"Mon, 11 Apr 2005 12:52:11 +0200")
Message-ID: <87y8bp8fiz.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Petr Baudis:

>> Almost certainly, v3 will be incompatible with v2 because it adds
>> further restrictions.  This means that your proposal would result in
>> software which is not redistributable by third parties.
>
> Hmm, what would be actually the point in introducing further
> restrictions? Anyone who then wants to get around them will just
> distribute the software with the "any later version" provision under
> GPLv2, and GPLv3 will have no impact expect for new software with "v3 or
> any later version" provision. What am I missing?

Software continues to evolve.  The copyright owners can relicense the
code base under v3, and use v3 for all subsequent changes to the
software.  The trouble with relicensing is that you have to contact
all copyright holders (or remove their code).  This tends to be
impossible in long-running projects without contractual agreements
between the developers.
