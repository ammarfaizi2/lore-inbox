Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVBOVyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVBOVyT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 16:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVBOVyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 16:54:19 -0500
Received: from mail.suse.de ([195.135.220.2]:39318 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261904AbVBOVyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 16:54:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
References: <jebramy75q.fsf@sykes.suse.de>
	<Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
	<je1xbhy3ap.fsf@sykes.suse.de>
	<Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: When I met th'POPE back in '58, I scrubbed him with a MILD SOAP
 or DETERGENT for 15 minutes.  He seemed to enjoy it..
Date: Tue, 15 Feb 2005 22:54:14 +0100
In-Reply-To: <Pine.LNX.4.58.0502151239160.2330@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 15 Feb 2005 12:56:52 -0800 (PST)")
Message-ID: <jevf8twku1.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> That's clearly not the case, and I haven't looked into exactly what
> termios settings "forkpty()" uses

If no termios is passed then the defaults are unchanged.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
