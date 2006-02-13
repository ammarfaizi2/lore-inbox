Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbWBMTFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbWBMTFf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWBMTFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:05:35 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:12757 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964804AbWBMTFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:05:34 -0500
Subject: Re: kernel BUG at arch/i386/mm/pageattr.c:137!
From: Lee Revell <rlrevell@joe-job.com>
To: Zeno Davatz <zdavatz@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40a4ed590602130924h2fa305dbye4e1c58e27c089ba@mail.gmail.com>
References: <40a4ed590602130924h2fa305dbye4e1c58e27c089ba@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 14:05:31 -0500
Message-Id: <1139857532.3202.40.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-13 at 17:24 +0000, Zeno Davatz wrote:
> Hi
> 
> I'm running Kernel. 2.6.15.4 and I compiled the newest sources for the
> Kernel with the Nvidia driver. When I start Xorg dmesg gives me the
> following:
> 
> kernel BUG at arch/i386/mm/pageattr.c:137!
> invalid operand: 0000 [#1]
> PREEMPT
> Modules linked in: nvidia wlan_scan_ap wlan_scan_sta ath_pci
> ath_rate_sample wlan ath_hal
> CPU:    0
> EIP:    0060:[<c0112dfa>]    Tainted: P      VLI

Why in the hell are you posting an Oops here that not only has the
nvidia driver loaded, but is clearly caused by it?!?

Please look up what "Tainted" means in the context of a kernel Oops.

Lee

