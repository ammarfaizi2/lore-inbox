Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUIPA6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUIPA6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 20:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267445AbUIPAxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 20:53:35 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:43661 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S267427AbUIPAvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 20:51:53 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Matt Kavanagh <matthew@teh.ath.cx>
Date: Thu, 16 Sep 2004 10:51:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16712.58252.103434.617821@cse.unsw.edu.au>
Cc: Patrick Kiwitter- Mailinglist <ccc@devilcode.de>,
       linux-kernel@vger.kernel.org
Subject: Re: monoholitic, hybrid or not monoholitic? [OT]
In-Reply-To: message from Matt Kavanagh on Wednesday September 15
References: <4148271D.9050009@devilcode.de>
	<20040915141237.GB2429@teh.ath.cx>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday September 15, matthew@teh.ath.cx wrote:
> I'd tend towards monolithic because the modules (as mentioned) run in kernel
> space; but it's not a cookie-cutter case. Things are implemented in userspace
> that provide functionality normally included in the kernel; udev springs to
> mind, even if it is not the predominant solution.

It is worth looking at the origin of the word "monolithic".

   mono -  prefix meaning one, singular, alone.
   lith -  rock
   -ic  -  suffix meaning like, or similar.

And given that
    Linux is Number One and it, like, ROCKS,
I guess monolithic must be the right term :-)

NeilBrown

(we now return you to regular programming)
