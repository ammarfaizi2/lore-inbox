Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWCUAbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWCUAbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 19:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWCUAbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 19:31:24 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:32216 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932225AbWCUAbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 19:31:23 -0500
Date: Mon, 20 Mar 2006 19:32:05 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Matheus Izvekov <mizvekov@gmail.com>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Who uses the 'nodev' flag in /proc/filesystems ???
Message-ID: <20060321003205.GA7860@ccure.user-mode-linux.org>
References: <17436.60328.242450.249552@cse.unsw.edu.au> <Pine.LNX.4.61.0603191024420.1409@yvahk01.tjqt.qr> <17438.13214.307942.212773@cse.unsw.edu.au> <Pine.LNX.4.61.0603201659250.22395@yvahk01.tjqt.qr> <305c16960603200817u3c8e4023nf2621245fdb0ed65@mail.gmail.com> <20060320175633.GA5797@ccure.user-mode-linux.org> <305c16960603201122t79dd93c1t484c83acf4ed191b@mail.gmail.com> <20060320194815.GA6376@ccure.user-mode-linux.org> <Pine.LNX.4.61.0603202057420.14231@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603202057420.14231@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 08:58:58PM +0100, Jan Engelhardt wrote:
> But hey, when hostfs is nodev-but-fsckable, then looking for /sbin/fsck.XYZ 
> is even better than reading /proc/filesystems...

It's humfs, BTW (hostfs consistency is maintained by the host), but yes.

				Jeff
