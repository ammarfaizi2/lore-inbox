Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131263AbQKPXri>; Thu, 16 Nov 2000 18:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131539AbQKPXrT>; Thu, 16 Nov 2000 18:47:19 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:1800 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S131263AbQKPXrH>; Thu, 16 Nov 2000 18:47:07 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDD2C@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: RE: "SubmittingPatches" text
Date: Thu, 16 Nov 2000 15:16:49 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

I compared my personal hints list to yours.
Yours is much more complete and better.

Here are a few comments for you to consider (below).

Thanks,
~Randy_________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------


> 4) Select e-mail destination.
> 
...

However, your patch(es) must be sent directly to Linus or to
other maintainers to send to Linus.  He doesn't troll linux-kernel
or other mailing lists looking for patches.


> 8) Name your kernel version.
> 
> It is important to note, either in the subject line or in the patch
> description, the kernel version to which this patch applies.

However, your patch should apply cleanly (no failures, little
to no fuzz) to the latest kernel version.

> 9) Don't get discouraged.  Re-submit.
> 
...
> It is quite common for Linus to "drop" your patch without comment.
> That's the nature of the system.  If he drops your patch, it could be
> due to
> * A style issue (see section 2),
> * An e-mail formatting issue (re-read this section)
> * A technical problem with your change
> * He gets tons of e-mail, and yours got lost in the shuffle
> * You are being annoying (See Figure 1)

+ * Your patch fails to apply or has (too much) fuzz.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
