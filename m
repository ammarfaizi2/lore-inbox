Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265736AbUGTIZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUGTIZW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 04:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265743AbUGTIZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 04:25:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:6025 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265724AbUGTIZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 04:25:17 -0400
To: davidm@hpl.hp.com
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: fix for unkillable zombie task
References: <16632.21429.257483.650452@napali.hpl.hp.com>
	<jesmbr3pfl.fsf@sykes.suse.de>
	<16636.7969.396569.877226@napali.hpl.hp.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Was my SOY LOAF left out in th'RAIN?  It tastes REAL GOOD!!
Date: Tue, 20 Jul 2004 10:23:32 +0200
In-Reply-To: <16636.7969.396569.877226@napali.hpl.hp.com> (David Mosberger's
 message of "Mon, 19 Jul 2004 12:21:05 -0700")
Message-ID: <jevfgjulx7.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> writes:

>>>>>> On Sat, 17 Jul 2004 12:20:46 +0200, Andreas Schwab <schwab@suse.de> said:
>
>   Andreas> Could this be the same problem as discussed in the thread at
>   Andreas> <http://marc.theaimsgroup.com/?t=108857537300002&r=1&w=2>?
>
> It appears the "final" patch never made it into Linus' tree?

And it appears to be a different issue, your patch doesn't fix that.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
