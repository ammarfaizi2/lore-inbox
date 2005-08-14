Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVHNFac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVHNFac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 01:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVHNFac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 01:30:32 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:61769 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932460AbVHNFac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 01:30:32 -0400
Date: Sun, 14 Aug 2005 15:30:17 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: IT8212/ITE RAID
Message-ID: <20050814053017.GA27824@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having an IDE card with one of these chipsets has left me with a bit of
a quandry. I've seen 2 different patch, both seemingly not going
anywhere.

1. Alan Cox's IDE driver that was included in his ac patchset, which
   seems to have died at 2.6.11ac7.
2. A brief visit from a SCSI IDE driver in Andrew Mortons mm patchset.
   It lived a brief but noted life before being taken out without any
   reason (that I spotted) in 2.6.12-rc4-mm1

Now, I'd like to upgrade my kernel to cover the security patches
releases since 11ac7 but... do I extract the ac driver or the mm driver
and try to use it? Will my data be eaten? Is there any chance of seeing
either driver in the kernel, proper?

Just wondering which way to go and stuff. :/

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
