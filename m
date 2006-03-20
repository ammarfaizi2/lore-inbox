Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWCTTrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWCTTrS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWCTTrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:47:18 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:14550 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964936AbWCTTrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:47:16 -0500
Date: Mon, 20 Mar 2006 14:48:15 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Who uses the 'nodev' flag in /proc/filesystems ???
Message-ID: <20060320194815.GA6376@ccure.user-mode-linux.org>
References: <17436.60328.242450.249552@cse.unsw.edu.au> <Pine.LNX.4.61.0603191024420.1409@yvahk01.tjqt.qr> <17438.13214.307942.212773@cse.unsw.edu.au> <Pine.LNX.4.61.0603201659250.22395@yvahk01.tjqt.qr> <305c16960603200817u3c8e4023nf2621245fdb0ed65@mail.gmail.com> <20060320175633.GA5797@ccure.user-mode-linux.org> <305c16960603201122t79dd93c1t484c83acf4ed191b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960603201122t79dd93c1t484c83acf4ed191b@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 04:22:51PM -0300, Matheus Izvekov wrote:
> I see, i didnt know about this. But then pam_mount would need to do
> special treatment for this. I imagine it has been only coded to work
> in the case where there is a device to pass to fsck as a parameter.

Yeah, I don't doubt it.  I was just commenting on the nodev aspect of this.

				Jeff
