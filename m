Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263035AbVDLXB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbVDLXB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbVDLW6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:58:31 -0400
Received: from ns2.suse.de ([195.135.220.15]:60139 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262354AbVDLW5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:57:53 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc64: very basic desktop g5 sound support (#2)
References: <1113282436.21548.42.camel@gaston> <jell7nu6yk.fsf@sykes.suse.de>
	<1113344225.21548.108.camel@gaston> <jey8bnk4lj.fsf@sykes.suse.de>
	<1113345561.5387.114.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Were these parsnips CORRECTLY MARINATED in TACO SAUCE?
Date: Wed, 13 Apr 2005 00:57:46 +0200
In-Reply-To: <1113345561.5387.114.camel@gaston> (Benjamin Herrenschmidt's
 message of "Wed, 13 Apr 2005 08:39:21 +1000")
Message-ID: <jeekdfk3h1.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Doesn't work with version 2 of the patch ? neither the headphone nor the
> line out jack ?

Yes.

> hrm... does it properly detect insertion of the jack and mute the
> speaker in both cases ?

Yes, it does.

> Can you send me a tarball of your device-tree ?

Will do.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
