Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbVIHU1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVIHU1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVIHU1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:27:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:146 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964988AbVIHU1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:27:08 -0400
Date: Thu, 8 Sep 2005 10:01:06 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IPW2100 Kconfig
Message-ID: <20050908080106.GB773@openzaurus.ucw.cz>
References: <005101c5b311_4ca69a50_a20cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005101c5b311_4ca69a50_a20cc60a@amer.sykes.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	I checked the IPW2100 in the current git from linux-2.6 and the menuconfig
> help (Kconfig) says you need to put the firmware in /etc/firmware, it should
> be /lib/firmware.
> 
> Who should I send the "patch" to? Or can someone simply change that?

Are you sure it is not distro-dependend?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

