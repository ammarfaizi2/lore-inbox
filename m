Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbVJ1VSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbVJ1VSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbVJ1VSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:18:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46778 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751806AbVJ1VSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:18:15 -0400
Date: Sat, 29 Oct 2005 07:15:52 +1000
From: Nathan Scott <nathans@sgi.com>
To: Adrian Bunk <bunk@stusta.de>, Dimitri Puzin <tristan-777@ddkom-online.de>
Cc: Andrew Morton <akpm@osdl.org>, stable@kernel.org,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [2.6 patch] fix XFS_QUOTA for modular XFS
Message-ID: <20051029071552.A6135176@wobbly.melbourne.sgi.com>
References: <20051028203325.GD4180@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051028203325.GD4180@stusta.de>; from bunk@stusta.de on Fri, Oct 28, 2005 at 10:33:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 10:33:25PM +0200, Adrian Bunk wrote:
> This patch by Dimitri Puzin submitted through kernel Bugzilla #5514 
> fixes the following issue:
> ...
> From: Dimitri Puzin <tristan-777@ddkom-online.de>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks guys; feel free to add:
Signed-off-by: Nathan Scott <nathans@sgi.com>

(Or Acked-by: or whatever).

cheers.

-- 
Nathan
