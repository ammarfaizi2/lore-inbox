Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbVJ1XGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVJ1XGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 19:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVJ1XGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 19:06:01 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:52622
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750745AbVJ1XGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 19:06:00 -0400
Message-ID: <4362AED6.2010704@linuxwireless.org>
Date: Fri, 28 Oct 2005 17:05:58 -0600
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: James Ketrenos <jketreno@linux.intel.com>
Subject: Re: IPW2200 againt 2.6.14-currentGit
References: <4362A32B.9040802@linuxwireless.org>
In-Reply-To: <4362A32B.9040802@linuxwireless.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla Beeche wrote:

> As of 2.6.14-git-current ipw2200 would not bind to a ethX name.
>
> In other words, ieee80211-1.0.7 and ipw2200-1.0.8 are making and 
> installing perfectly, also ipw2200 module is getting loaded but 
> nothing will come up for wireless under iwconfig nor under ifconfig -a.
>
> dmesg looked perfectly normal. Maybe this has anything to do with the 
> Greg KH changes?
>
> (2.6.14-rc5 and I have heard 2.6.14 work perfectly)
>
> Also, how can I debug or check what could be occuring? or should I 
> just wait because there are too many things going in?
>
> .Alejandro

Dissregard, after git pulling again, it looks like things work.

.Alejandro
