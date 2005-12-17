Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932656AbVLQS6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbVLQS6m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 13:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbVLQS6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 13:58:42 -0500
Received: from mail.gmx.net ([213.165.64.21]:5292 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932656AbVLQS6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 13:58:41 -0500
X-Authenticated: #7534793
Date: Sat, 17 Dec 2005 19:58:38 +0100
From: Gerhard Schrenk <deb.gschrenk@gmx.de>
To: Andi Kleen <ak@suse.de>
Cc: Gerhard Schrenk <deb.gschrenk@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Correction for broken MCFG tables on K8 breaks acpi for MSI S260
Message-ID: <20051217185838.GA5605@mailhub.uni-konstanz.de>
References: <20051217005109.GA11982@mailhub.uni-konstanz.de> <20051217034755.GV23384@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217034755.GV23384@wotan.suse.de>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@suse.de> [2005-12-17 13:33]:
> On Sat, Dec 17, 2005 at 01:51:09AM +0100, Gerhard Schrenk wrote:
> > commit d6ece5491ae71ded1237f59def88bcd1b19b6f60 breaks acpi for my
> > Medion MD 95600 (aka MSI S260) notebook.
> 
> Should be already fixed in Linus' tree.

Yes, current kernel boots for me with option noapic. Sorry for the false
alarm.  You guys do simply fix bugs quicker than I can get a digicam
from a friend of mine...

-- Gerhard
