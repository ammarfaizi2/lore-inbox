Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUGTQIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUGTQIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 12:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUGTQIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 12:08:41 -0400
Received: from palrel13.hp.com ([156.153.255.238]:58786 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265971AbUGTQIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 12:08:10 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16637.17254.121371.640514@napali.hpl.hp.com>
Date: Tue, 20 Jul 2004 09:08:06 -0700
To: Andreas Schwab <schwab@suse.de>
Cc: davidm@hpl.hp.com, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: fix for unkillable zombie task
In-Reply-To: <jevfgjulx7.fsf@sykes.suse.de>
References: <16632.21429.257483.650452@napali.hpl.hp.com>
	<jesmbr3pfl.fsf@sykes.suse.de>
	<16636.7969.396569.877226@napali.hpl.hp.com>
	<jevfgjulx7.fsf@sykes.suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 20 Jul 2004 10:23:32 +0200, Andreas Schwab <schwab@suse.de> said:

  Andreas> David Mosberger <davidm@napali.hpl.hp.com> writes:
  >>>>>>> On Sat, 17 Jul 2004 12:20:46 +0200, Andreas Schwab
  >>>>>>> <schwab@suse.de> said:
  >>
  Andreas> Could this be the same problem as discussed in the thread
  Andreas> at
  Andreas> <http://marc.theaimsgroup.com/?t=108857537300002&r=1&w=2>?

  >>  It appears the "final" patch never made it into Linus' tree?

  Andreas> And it appears to be a different issue, your patch doesn't
  Andreas> fix that.

Do you have a simple test-case?

	--david
