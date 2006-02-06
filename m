Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWBFHJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWBFHJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWBFHJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:09:06 -0500
Received: from fmr19.intel.com ([134.134.136.18]:2707 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750767AbWBFHJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:09:04 -0500
Subject: Re: [2.6 patch] let IPW2{1,2}00 select IEEE80211
From: Zhu Yi <yi.zhu@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: jketreno@linux.intel.com, linville@tuxdriver.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jan Niehusmann <jan@gondor.com>
In-Reply-To: <20060205151322.GE5271@stusta.de>
References: <20060205151322.GE5271@stusta.de>
Content-Type: text/plain
Organization: Intel Corp.
Date: Mon, 06 Feb 2006 15:02:29 +0800
Message-Id: <1139209350.4784.13.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-05 at 16:13 +0100, Adrian Bunk wrote:
> From: Jan Niehusmann <jan@gondor.com>
> 
> This patch makes the IPW2100 and IPW2200 options available in
> the configuration menu even if IEEE80211 has not been selected before.
> This behaviour is more intuitive for people which are not familiar with
> the driver internals.
> The suggestion for this change was made by Alejandro Bonilla Beeche.
> 
> Signed-off-by: Jan Niehusmann <jan@gondor.com>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Zhu Yi <yi.zhu@intel.com>

Thanks,
-yi

