Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932840AbWCRBRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbWCRBRG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 20:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932830AbWCRBRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 20:17:05 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:62480 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932786AbWCRBRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 20:17:04 -0500
Date: Fri, 17 Mar 2006 20:13:47 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: yi.zhu@intel.com, jketreno@linux.intel.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/wireless/ipw2200.c: fix an array overun
Message-ID: <20060318011342.GG25249@tuxdriver.com>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, yi.zhu@intel.com,
	jketreno@linux.intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060311034258.GJ21864@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060311034258.GJ21864@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2006 at 04:42:58AM +0100, Adrian Bunk wrote:
> This patch fixes a big array overun found by the Coverity checker.

Merged to upstream branch of wireless-2.6...thanks!

John
-- 
John W. Linville
linville@tuxdriver.com
