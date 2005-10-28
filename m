Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbVJ1WQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbVJ1WQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbVJ1WQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:16:16 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:45954
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1030409AbVJ1WQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:16:14 -0400
Message-ID: <4362A32B.9040802@linuxwireless.org>
Date: Fri, 28 Oct 2005 16:16:11 -0600
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, James Ketrenos <jketreno@linux.intel.com>
Subject: IPW2200 againt 2.6.14-currentGit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of 2.6.14-git-current ipw2200 would not bind to a ethX name.

In other words, ieee80211-1.0.7 and ipw2200-1.0.8 are making and 
installing perfectly, also ipw2200 module is getting loaded but nothing 
will come up for wireless under iwconfig nor under ifconfig -a.

dmesg looked perfectly normal. Maybe this has anything to do with the 
Greg KH changes?

(2.6.14-rc5 and I have heard 2.6.14 work perfectly)

Also, how can I debug or check what could be occuring? or should I just 
wait because there are too many things going in?

.Alejandro
