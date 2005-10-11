Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVJKDAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVJKDAy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 23:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVJKDAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 23:00:54 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:4563
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1751268AbVJKDAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 23:00:53 -0400
Message-ID: <434B2AE2.1070709@linuxwireless.org>
Date: Mon, 10 Oct 2005 21:00:50 -0600
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
CC: James Ketrenos <jketreno@linux.intel.com>
Subject: IPW Question on menuconfig
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    I was just git updating 2.6.14-rc4 and I didn't have the 
CONFIG_IEEE80211 module selected, then I went into Device Drivers / 
Network devices / Wireless, and the IPW2100 wasn't in the list. I went, 
then Modularized the IEEE80211 and then IPW2100 was there. I think is 
kind of estrange that IPW2100 wouldn't show just because it has a 
dependencie, shouldn't IPW2100 show in the list, and if you select it, 
then it would also select CONFIG_IEEE80211?

Just a dumb question cause I dunno how is normally done or the policy to 
do this.

.Alejandro
