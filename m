Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVAGBlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVAGBlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 20:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVAGBkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 20:40:53 -0500
Received: from holomorphy.com ([207.189.100.168]:31171 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261284AbVAGBfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 20:35:45 -0500
Date: Thu, 6 Jan 2005 17:32:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/hugetlbfs/inode.c: make 4 functions static
Message-ID: <20050107013230.GG9636@holomorphy.com>
References: <20050107012900.GD14108@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107012900.GD14108@stusta.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 02:29:00AM +0100, Adrian Bunk wrote:
> The patch below makes four needlessly global functions static.
> diffstta output:
>  fs/hugetlbfs/inode.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
