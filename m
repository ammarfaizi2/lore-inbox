Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVJaVQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVJaVQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbVJaVQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:16:19 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:3223 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932501AbVJaVQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:16:18 -0500
Date: Tue, 1 Nov 2005 08:13:27 +1100
From: Nathan Scott <nathans@sgi.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       stable@kernel.org, linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       Dimitri Puzin <tristan-777@ddkom-online.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] [2.6 patch] fix XFS_QUOTA for modular XFS
Message-ID: <20051101081327.C6220221@wobbly.melbourne.sgi.com>
References: <20051028203325.GD4180@stusta.de> <20051031210305.GR5856@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051031210305.GR5856@shell0.pdx.osdl.net>; from chrisw@osdl.org on Mon, Oct 31, 2005 at 01:03:05PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 01:03:05PM -0800, Chris Wright wrote:
> * Adrian Bunk (bunk@stusta.de) wrote:
> > This patch by Dimitri Puzin submitted through kernel Bugzilla #5514 
> > fixes the following issue:
> > 
> > Cannot build XFS filesystem support as module with quota support. It 
> > works only when the XFS filesystem support is compiled into the kernel. 
> > Menuconfig prevents from setting CONFIG_XFS_FS=m and CONFIG_XFS_QUOTA=y.
> 
> Thanks, will queue for -stable, but this hasn't made it upstream yet.

Sorry, public holiday here has meant no action on that front - it
is "good to go" though, and will be sent to Linus when I'm back in
the office.

cheers.

-- 
Nathan
