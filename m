Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWBLWDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWBLWDn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 17:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWBLWDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 17:03:43 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:45231 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751476AbWBLWDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 17:03:42 -0500
Subject: Re: [RFC: 2.6 patch] CONFIG_FORCEDETH updates
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060212175202.GK30922@stusta.de>
References: <20060212175202.GK30922@stusta.de>
Content-Type: text/plain
Date: Sun, 12 Feb 2006 17:03:36 -0500
Message-Id: <1139781817.19342.300.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-12 at 18:52 +0100, Adrian Bunk wrote:
> This patch contains the following possible updates:
> - let FORCEDETH no longer depend on EXPERIMENTAL
> - remove the "Reverse Engineered" from the option text:
>   for the user it's important which hardware the driver supports, not
>   how it was developed

Is this driver as stable as one that was developed with proper
documentation?  I prefer to know that something as elementary as a fast
ethernet controller had to be reverse engineered so I can avoid
supporting a vendor so hostile to Linux.

Lee

