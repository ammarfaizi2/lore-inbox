Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVBSAYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVBSAYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVBSAYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:24:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63387 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261563AbVBSASj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:18:39 -0500
Message-ID: <421685CB.4010606@pobox.com>
Date: Fri, 18 Feb 2005 19:18:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/shaper.c: cleanups
References: <20050219001018.GK4337@stusta.de>
In-Reply-To: <20050219001018.GK4337@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following cleanups:
> - remove an unused #define SHAPER_BANNER
> - remove the sh_debug flag
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

you are removing presumably-useful debug code; NAK.


