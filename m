Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVCBQwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVCBQwq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVCBQvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:51:04 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:38273 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262364AbVCBQsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:48:04 -0500
Date: Wed, 2 Mar 2005 17:47:59 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11
Message-ID: <20050302164759.GA30505@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> <20050302103158.GA13485@merlin.emma.line.org> <Pine.LNX.4.58.0503020738300.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503020738300.25732@ppc970.osdl.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005, Linus Torvalds wrote:

> On Wed, 2 Mar 2005, Matthias Andree wrote:
> > 
> > ftp.kernel.org:/pub/linux/kernel/v2.6 doesn't seem to carry a crypto
> > signature for the patch, patch-2.6.11.gz.sign
> 
> It's there now (along with the ChangeLog).

> The signatures are automatically generated at the master site, and the 
> mirroring out to the public sites is a separate event, so sometimes (if 
> you check early) you may miss the signatures for a while until the next 
> time the scripts run.

Is the master side a hidden host rather than ftp.kernel.org?

> (In contrast the full ChangeLog was missing because the generation script
> I use is not exactly the smart way, so it's O(slow(n)), where slow is n**3 
> or worse, so the log from the last -rc release is fast, but going back all 
> the way to 2.6.10 took long long enough that I didn't wait for it).

If that is an issue with the shortlog script or its integration with BK,
contact me off-list so we can resolve the issue.

Thanks,

-- 
Matthias Andree
