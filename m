Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVCGIdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVCGIdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVCGIae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:30:34 -0500
Received: from smartmx-05.inode.at ([213.229.60.37]:17801 "EHLO
	smartmx-05.inode.at") by vger.kernel.org with ESMTP id S261705AbVCGIaU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:30:20 -0500
Message-ID: <422C111B.5040209@inode.info>
Date: Mon, 07 Mar 2005 09:30:19 +0100
From: Richard Fuchs <richard.fuchs@inode.info>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Scott Feldman <sfeldma@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: slab corruption in skb allocs
References: <42283093.7040405@inode.info> <20050304035309.1da7774e.akpm@osdl.org> <42285354.5090900@inode.info> <93832c6db45c33f7b2f195aae0d469dc@pobox.com> <422A041E.40105@inode.info> <0a8f9833de8ba3f767f3b3211bbb693a@pobox.com> <422B4E97.4090303@inode.info> <bda000da0eb3b797500d90992d30a99d@pobox.com>
In-Reply-To: <bda000da0eb3b797500d90992d30a99d@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Feldman wrote:

> Would you mind giving this patch a try against 2.6.11?  I think it's 
> equivalent to Jesse's patch, but less intrusive to the driver.

looks good, no more memory corruption errors. thanks for this.

cheers
richard
