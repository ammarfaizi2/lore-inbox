Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVGHE2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVGHE2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 00:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVGHE2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 00:28:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:59281 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262594AbVGHE2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 00:28:53 -0400
Date: Fri, 8 Jul 2005 14:21:46 +1000
From: Nathan Scott <nathans@sgi.com>
To: Yura Pakhuchiy <pakhuchiy@gmail.com>
Cc: linux-xfs@oss.sgi.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, tibor@altlinux.ru
Subject: Re: XFS corruption on move from xscale to i686
Message-ID: <20050708042146.GA1679@frodo>
References: <1120756552.5298.10.camel@pc299.sam-solutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120756552.5298.10.camel@pc299.sam-solutions.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 08:15:52PM +0300, Yura Pakhuchiy wrote:
> Hi,
> 
> I'm creadted XFS volume on 2.6.10 linux xscale/iq31244 box, then I
> copyied files on it and moved this hard drive to i686 machine. When I
> mounted it on i686, I found no files on it. I runned xfs_check, here is
> output:

Someone else was doing this awhile back, and also had issues.
Their trouble seemed to be related to xscale gcc miscompiling
parts of XFS - search the linux-xfs archives for details.

cheers.

-- 
Nathan
