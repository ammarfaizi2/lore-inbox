Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267381AbUHDTSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267381AbUHDTSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267383AbUHDTSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:18:53 -0400
Received: from havoc.gtf.org ([216.162.42.101]:45260 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267381AbUHDTSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:18:52 -0400
Date: Wed, 4 Aug 2004 15:18:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-ID: <20040804191850.GA19224@havoc.gtf.org>
References: <2ppN4-1wi-11@gated-at.bofh.it> <2pvps-5xO-33@gated-at.bofh.it> <2pvz2-5Lf-19@gated-at.bofh.it> <2pwbQ-68b-43@gated-at.bofh.it> <m33c32ke3f.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m33c32ke3f.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 07:28:04PM +0200, Andi Kleen wrote:
> So please never pass any structures with read/write/netlink.

Sorry...  This is pretty much a given IMO.

	Jeff



