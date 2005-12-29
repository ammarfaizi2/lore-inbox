Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVL2Qmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVL2Qmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVL2QlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:41:13 -0500
Received: from mail.dvmed.net ([216.237.124.58]:23264 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750821AbVL2QlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:41:04 -0500
Message-ID: <43B41193.1070407@pobox.com>
Date: Thu, 29 Dec 2005 11:40:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: York Liu <york_liu@linux.intel.com>
CC: linux-kernel@vger.kernel.org, Netdev List <netdev@vger.kernel.org>
Subject: Re: [Announce] Intel PRO/Wireless 2200BG 802.11b/g Access Point Project
References: <2871.172.28.120.79.1135842580.squirrel@172.28.120.79>
In-Reply-To: <2871.172.28.120.79.1135842580.squirrel@172.28.120.79>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  York Liu wrote: > Intel is pleased to announce the
	launch of an open source project to > extend the current Intel
	PRO/Wireless 2200BG Driver project (IPW2200) to > support Master
	(Access Point) mode. The project site is up and in the > coming weeks
	you can expect initial source to become available providing > the
	limited access point functionality. This will be a point release, and >
	the code is intended to be used as it however any bug fixes and patches
	> are welcome. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

York Liu wrote:
> Intel is pleased to announce the launch of an open source project to
> extend the current Intel PRO/Wireless 2200BG Driver project (IPW2200) to
> support Master (Access Point) mode. The project site is up and in the
> coming weeks you can expect initial source to become available providing
> the limited access point functionality. This will be a point release, and
> the code is intended to be used as it however any bug fixes and patches
> are welcome.

Will this code be a series of patches against the upstream kernel?

Will this code use the existing HostAP + ieee80211 code as a starting point?

What sort of discussion has occurred with the other wireless developers, 
such as those on netdev@vger.kernel.org list?

	Jeff


