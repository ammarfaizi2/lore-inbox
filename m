Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWBFHIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWBFHIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 02:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWBFHIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 02:08:49 -0500
Received: from fmr17.intel.com ([134.134.136.16]:9858 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750779AbWBFHIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 02:08:48 -0500
Subject: Re: [2.6 patch] wrong firmware location in IPW2100 Kconfig entry
From: Zhu Yi <yi.zhu@intel.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       jketreno@linux.intel.com
In-Reply-To: <20060131161124.GA3986@stusta.de>
References: <20060131161124.GA3986@stusta.de>
Content-Type: text/plain
Organization: Intel Corp.
Date: Mon, 06 Feb 2006 15:02:19 +0800
Message-Id: <1139209340.4784.11.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-31 at 17:11 +0100, Adrian Bunk wrote:
> From: Jesper Juhl <jesper.juhl@gmail.com>
> 
> Firmware should go into /lib/firmware, not /etc/firmware.
> 
> Found by Alejandro Bonilla.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Zhu Yi <yi.zhu@intel.com>

Thanks,
-yi

