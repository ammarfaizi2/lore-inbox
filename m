Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVJRNxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVJRNxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 09:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVJRNxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 09:53:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27520 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750725AbVJRNxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 09:53:03 -0400
Date: Tue, 18 Oct 2005 23:52:57 +1000
From: Nathan Scott <nathans@sgi.com>
To: Srikumar Subramanian <SrikumarS@ami.com>
Cc: linux-kernel@vger.kernel.org, Prabhakar Krishnan <kpkar@ami.com>
Subject: Re: Kernel Panic in XFS ACL
Message-ID: <20051018235257.A5830881@wobbly.melbourne.sgi.com>
References: <3225AF1B8CBF83459982D4987F1549CE055EE5@fre-ops.us.megatrends.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3225AF1B8CBF83459982D4987F1549CE055EE5@fre-ops.us.megatrends.com>; from SrikumarS@ami.com on Mon, Oct 17, 2005 at 08:55:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 08:55:51PM -0400, Srikumar Subramanian wrote:
> Hi All,
> 
> I am using FC3: kernel 2.6.9-1.667smp
> ...
> But when the XFS file system goes out of space, it stops with a panic. It is
> reproducible consistently.
> 
> I have typein the kernel dump:
> EIP at 0060 :[44bf9bbc]
> EIP at xfs_ail_insert

This is fixed in more recent kernels.

cheers.

-- 
Nathan
