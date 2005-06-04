Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVFDTP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVFDTP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 15:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVFDTP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 15:15:56 -0400
Received: from stark.xeocode.com ([216.58.44.227]:33725 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261423AbVFDTPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 15:15:48 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, Greg Stark <gsstark@mit.edu>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>
	<42A1E96C.6080806@pobox.com> <20050604185028.GZ4992@stusta.de>
	<42A1FB91.5060702@pobox.com>
In-Reply-To: <42A1FB91.5060702@pobox.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 04 Jun 2005 15:15:24 -0400
Message-ID: <87psv2j5mb.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik <jgarzik@pobox.com> writes:

> All my development is in public; all the data is there for anyone who wishes to
> use it.

That is cool. And it's nice that there seems to have been an upsurge in the
quantity of communication from you and other libata developers on this list
too.

I expect if git catches on then it would be about as effective as most
projects which publish their CVS tree and expect people to be able to do
checkouts from there. Currently, though, approximately nobody has git tools or
any idea how to use it.


So my question is, if I did tackle this riddle trail and figured out how to
fetch the passthru branch against 2.6.12, what would it buy me? Would SMART
just start working? Or would it just confuse the SMART tools until they're
updated? Or would it just crash my machine?


-- 
greg

