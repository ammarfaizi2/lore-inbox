Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUHSO2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUHSO2B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUHSO2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:28:01 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:14814 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266221AbUHSO16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:27:58 -0400
X-Envelope-From: kraxel@bytesex.org
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: kernel@wildsau.enemy.org, diablod3@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	<d577e5690408190004368536e9@mail.gmail.com>
	<4124A024.nail7X62HZNBB@burner>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 19 Aug 2004 16:14:05 +0200
In-Reply-To: <4124A024.nail7X62HZNBB@burner>
Message-ID: <87vfffp64y.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> writes:

> >If no one has noticed yet, thanks to the additional license
> >restrictions Joerg Schilling has added to cdrecord (due to this
> >thread), it may be now moved to non-free in Debian in the near future.
> 
> Your statement "it may be now moved to non-free in Debian in the near future"
> is just complete nonsense.

It's not.

> Of course, I am in discussions with Debian people about the best
> method to force SuSE not to publish broken versions of cdrtools in
> the future.

Just read the Debian Free Software Guidelines.  You can't do that if
you want cdrecord stay in main and not go to non-free.  See paragraph
#3 of DFSG: "The license must allow modifications and derived works"
and paragraph #8: "License Must Not Be Specific to Debian".  Also note
#5: "No Discrimination Against Persons or Groups".

> The GPL requires you not to impact the original authors'
> reputations, but this is what SuSE is doing by publishing defective
> variants.

Those "defective variants" (which are NOT defective for me) clearly
state that they are *not* the original version and problems/bugs
should be reported to suse (as suggested by the GPL paragraph you are
refering to).  An it's not somewhere hidden, but printed every single
time you start it to the terminal, four lines long.

  Gerd

-- 
return -ENOSIG;
