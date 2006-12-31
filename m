Return-Path: <linux-kernel-owner+w=401wt.eu-S933129AbWLaL2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933129AbWLaL2e (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 06:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933131AbWLaL2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 06:28:34 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40003 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933129AbWLaL2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 06:28:33 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Dec 2006 06:28:33 EST
Message-ID: <45979DA8.6060208@drzeus.cx>
Date: Sun, 31 Dec 2006 12:23:20 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: kyungmin.park@samsung.com
CC: tony@atomide.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP: fix MMC workqueue changes
References: <3367638.643601167183892240.JavaMail.weblogic@ep_ml27>
In-Reply-To: <3367638.643601167183892240.JavaMail.weblogic@ep_ml27>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyungmin Park wrote:
> [PATCH] ARM: OMAP: fix MMC workqueue changes
> 
> fix OMAP MMC workqueue in recent workqueue change
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 

Applied thanks.

In the future, please add a "--" after the signed-off-by lines so that git can parse the email.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
