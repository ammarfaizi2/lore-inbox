Return-Path: <linux-kernel-owner+w=401wt.eu-S932089AbXACUaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbXACUaf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbXACUaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:30:35 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:59191 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094AbXACUae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:30:34 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Wed, 3 Jan 2007 21:29:49 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [2.6 patch] the scheduled IEEE1394_EXPORT_FULL_API removal
To: Adrian Bunk <bunk@stusta.de>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20070102215657.GB20714@stusta.de>
Message-ID: <tkrat.ec886bbdc5e889bc@s5r6.in-berlin.de>
References: <20070102215657.GB20714@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  2 Jan, Adrian Bunk wrote:
> This patch contains the scheduled IEEE1394_EXPORT_FULL_API removal.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  Documentation/feature-removal-schedule.txt |    8 -------
>  drivers/ieee1394/Kconfig                   |    7 ------
>  drivers/ieee1394/ieee1394_core.c           |   22 ---------------------
>  3 files changed, 37 deletions(-)
...

Committed to linux1394-2.6.git with the proper section of
feature-removal-schedule.txt pulled out.
-- 
Stefan Richter
-=====-=-=== ---= ---==
http://arcgraph.de/sr/

