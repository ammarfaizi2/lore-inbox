Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWGaAXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWGaAXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 20:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWGaAXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 20:23:08 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:7955 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1750935AbWGaAXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 20:23:07 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: ipw3945 status
Date: Mon, 31 Jul 2006 01:23:06 +0100
User-Agent: KMail/1.9.3
Cc: Theodore Tso <tytso@mit.edu>, Kasper Sandberg <lkml@metanurb.dk>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Jan Dittmer <jdi@l4x.org>,
       Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
References: <20060730104042.GE1920@elf.ucw.cz> <20060730145305.GE23279@thunk.org> <20060730231251.GB1800@elf.ucw.cz>
In-Reply-To: <20060730231251.GB1800@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607310123.06177.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 00:12, Pavel Machek wrote:
[snip]
> And... Intel will not even tell you WTF that daemon does. They claim
> it is for FCC, but it seems to be doing more than that. So maybe I'm
> not _that_ paranoid.

Agreed, from what Matthew's said it seems like the daemon is being used to 
hide intellectual property, not something we should really be encouraging.

I think the title "regulatory daemon" has multiple meanings, it REGULATES your 
frequencies to FCC specs, it REGULATES your wireless card's power and 
temperature levels, and it REGULATES your right to use the hardware ;-)

Ultimately the question remains, will we open this can of worms by accepting 
drivers that depend on proprietary software (i.e. they will not function at 
all without it). I'm fairly sure the answer should be "No".

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
