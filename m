Return-Path: <linux-kernel-owner+w=401wt.eu-S1752486AbXACA4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbXACA4x (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 19:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbXACA4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 19:56:53 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:33970 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbXACA4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 19:56:52 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <459AFF31.6030906@s5r6.in-berlin.de>
Date: Wed, 03 Jan 2007 01:56:17 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] the scheduled IEEE1394_EXPORT_FULL_API removal
References: <20070102215657.GB20714@stusta.de>
In-Reply-To: <20070102215657.GB20714@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
>  Documentation/feature-removal-schedule.txt |    8 -------
>  drivers/ieee1394/Kconfig                   |    7 ------
>  drivers/ieee1394/ieee1394_core.c           |   22 ---------------------
>  3 files changed, 37 deletions(-)
> 
> --- linux-2.6.20-rc2-mm1/Documentation/feature-removal-schedule.txt.old	2007-01-02 21:09:52.000000000 +0100
> +++ linux-2.6.20-rc2-mm1/Documentation/feature-removal-schedule.txt	2007-01-02 21:10:00.000000000 +0100
> @@ -61,8 +60,0 @@
> -What:	ieee1394's *_oui sysfs attributes (CONFIG_IEEE1394_OUI_DB)
> -When:	January 2007
> -Files:	drivers/ieee1394/: oui.db, oui2c.sh
> -Why:	big size, little value
> -Who:	Stefan Richter <stefanr@s5r6.in-berlin.de>
> -
> ----------------------------
> -

This hunk is wrong.
-- 
Stefan Richter
-=====-=-=== ---= ---==
http://arcgraph.de/sr/
