Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUKVLMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUKVLMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 06:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUKVLMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 06:12:06 -0500
Received: from news.suse.de ([195.135.220.2]:62864 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262060AbUKVLG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 06:06:58 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Roland McGrath <roland@redhat.com>, Daniel Jacobowitz <dan@debian.org>,
       Eric Pouech <pouech-eric@wanadoo.fr>, Mike Hearn <mh@codeweavers.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	<419E42B3.8070901@wanadoo.fr>
	<Pine.LNX.4.58.0411191119320.2222@ppc970.osdl.org>
	<419E4A76.8020909@wanadoo.fr>
	<Pine.LNX.4.58.0411191148480.2222@ppc970.osdl.org>
	<419E5A88.1050701@wanadoo.fr> <20041119212327.GA8121@nevyn.them.org>
	<Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	<20041120214915.GA6100@tesore.ph.cox.net>
	<Pine.LNX.4.58.0411211326350.11274@bigblue.dev.mdolabs.com>
	<Pine.LNX.4.58.0411211414460.20993@ppc970.osdl.org>
	<je7joe91wz.fsf@sykes.suse.de>
	<Pine.LNX.4.58.0411211703160.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0411211947200.11274@bigblue.dev.mdolabs.com>
	<Pine.LNX.4.58.0411212022510.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0411212212530.20993@ppc970.osdl.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I feel like I'm in a Toilet Bowl with a thumbtack in my forehead!!
Date: Mon, 22 Nov 2004 12:06:55 +0100
In-Reply-To: <Pine.LNX.4.58.0411212212530.20993@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 21 Nov 2004 22:23:41 -0800 (PST)")
Message-ID: <je7joeywfk.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> IMHO, this is a nice cleanup, and it also means that I can actually debug 
> my "program from hell":

Does it also work when trying to single step over it?  I guess all bets
are off then.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
