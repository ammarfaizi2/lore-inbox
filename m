Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUGTUPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUGTUPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUGTUMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 16:12:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:19637 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266252AbUGTUKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 16:10:46 -0400
To: davidm@hpl.hp.com
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: fix for unkillable zombie task
References: <16632.21429.257483.650452@napali.hpl.hp.com>
	<jesmbr3pfl.fsf@sykes.suse.de>
	<16636.7969.396569.877226@napali.hpl.hp.com>
	<jevfgjulx7.fsf@sykes.suse.de>
	<16637.17254.121371.640514@napali.hpl.hp.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: ..  If I had heart failure right now, I couldn't be a more fortunate
 man!!
Date: Tue, 20 Jul 2004 22:10:44 +0200
In-Reply-To: <16637.17254.121371.640514@napali.hpl.hp.com> (David
 Mosberger's message of "Tue, 20 Jul 2004 09:08:06 -0700")
Message-ID: <jeoemaqw1n.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> writes:

>>>>>> On Tue, 20 Jul 2004 10:23:32 +0200, Andreas Schwab <schwab@suse.de> said:
>
>   Andreas> David Mosberger <davidm@napali.hpl.hp.com> writes:
>   >>>>>>> On Sat, 17 Jul 2004 12:20:46 +0200, Andreas Schwab
>   >>>>>>> <schwab@suse.de> said:
>   >>
>   Andreas> Could this be the same problem as discussed in the thread
>   Andreas> at
>   Andreas> <http://marc.theaimsgroup.com/?t=108857537300002&r=1&w=2>?
>
>   >>  It appears the "final" patch never made it into Linus' tree?
>
>   Andreas> And it appears to be a different issue, your patch doesn't
>   Andreas> fix that.
>
> Do you have a simple test-case?

See the thread.
<http://marc.theaimsgroup.com/?l=linux-kernel&m=108858649619256> has mine,
I don't know whether the one in
<http://marc.theaimsgroup.com/?l=linux-kernel&m=108866581316414> tests the
same.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
