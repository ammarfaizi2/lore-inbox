Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWHaFGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWHaFGj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 01:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWHaFGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 01:06:39 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:34801 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1750753AbWHaFGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 01:06:38 -0400
To: Nathan Scott <nathans@sgi.com>
Cc: David Chinner <dgc@sgi.com>, xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Fix i_state of inode is changed after the inode is freed [try #2]
In-reply-to: <20060831131902.H3208450@wobbly.melbourne.sgi.com>
Message-Id: <20060831140643m-saito@mail.aom.tnes.nec.co.jp>
References: <20060831131902.H3208450@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Thu, 31 Aug 2006 14:06:43 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Are the patches going to be merged?
>
>Yep, they're queued up for 2.6.19.  Since it was a race found
>only on testing with a ramdisk (iirc) it didn't really seem to
>me like they needed to be rushed through for a 2.6.18-rc.  The
>race has also been there for the entire lifetime of the Linux
>XFS port... so, not urgent (and not risk free either).

Thanks, I agree it.  I'm looking forward to receiving the TAKE.
So far thank you, Nathan.  I wish to be glorious in your future.

cheers.

--
Masayuki
