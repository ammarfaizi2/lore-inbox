Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWCRBO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWCRBO5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 20:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932827AbWCRBO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 20:14:57 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:52752 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932304AbWCRBO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 20:14:56 -0500
Date: Fri, 17 Mar 2006 20:11:35 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: yi.zhu@intel.com, jketreno@linux.intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/wireless/ipw2200.c: make ipw_qos_current_mode() static
Message-ID: <20060318011130.GC25249@tuxdriver.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, yi.zhu@intel.com,
	jketreno@linux.intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
References: <20060304121431.GN9295@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304121431.GN9295@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 01:14:31PM +0100, Adrian Bunk wrote:
> This patch makes the needlessly global function ipw_qos_current_mode() 
> static.

Merged to upstream branch of wireless-2.6...thanks!

John
-- 
John W. Linville
linville@tuxdriver.com
