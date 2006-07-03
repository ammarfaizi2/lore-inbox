Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWGCWK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWGCWK6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWGCWK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:10:58 -0400
Received: from viefep14-int.chello.at ([213.46.255.14]:7462 "EHLO
	viefep14-int.chello.at") by vger.kernel.org with ESMTP
	id S1750741AbWGCWK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:10:58 -0400
Date: Tue, 4 Jul 2006 00:11:17 +0200
From: Hungerburg <lklm@lazy.shacknet.nu>
To: linux-kernel@vger.kernel.org
Subject: thank you, xfs team
Message-ID: <20060703221117.GA27898@lazy.shacknet.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello there,

I hope this is not the wrong place, yet I have to write this now, before
I forget about it:

I had to swap a dying harddrive. after receiving many mails from the
smart daemon, recent kernel patches to xfs made me aware of the full
extent of the problem.

keywords:
- XFS internal error XFS_WANT_CORRUPTED_RETURN
- Device: /dev/hda, 1 Currently unreadable (pending) sectors
- Device: /dev/hda, 1 Offline uncorrectable sectors

the tools to copy what is still there (data) are a boon - they require
some reading, but the thing is doable (xfs_copy to good disk, then
xfs_dump from there)

yours

Hungerburg

-- 
||| | | | | |  |  |  |   http://arton.cunst.net/   |  |  |  | | | | | |||

