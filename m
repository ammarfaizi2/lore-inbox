Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVA0GTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVA0GTB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVA0GTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:19:01 -0500
Received: from holomorphy.com ([66.93.40.71]:8066 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262490AbVA0GS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:18:59 -0500
Date: Wed, 26 Jan 2005 22:18:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050127061857.GX10843@holomorphy.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> - Lots of updates and fixes all over the place.
> - On my test box there is no flashing cursor on the vga console.  Known bug,
>   please don't report it.
>   Binary searching shows that the bug was introduced by
>   cleanup-vc-array-access.patch but that patch is, unfortunately, huge.

autofs has exploded far, far beyond complete nonfunctionality, where
in prior 2.6.x it was not quite so blatantly a doorstop preventing all
logins on the machine, and, in fact, multiuser mode altogether.

Whoever's responsible, prepare to be flamed to a crisp the likes of
which has never been witnessed before by observers of solar probes, nor
conceived of by the most visionary and imaginative of eschatologists.


-- wli
