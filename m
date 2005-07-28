Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVG1QRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVG1QRu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 12:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVG1QRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 12:17:04 -0400
Received: from mail.dvmed.net ([216.237.124.58]:62409 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261497AbVG1QPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 12:15:23 -0400
Message-ID: <42E90495.4050908@pobox.com>
Date: Thu, 28 Jul 2005 12:15:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jar <jar@pcuf.fi>
CC: linux-kernel@vger.kernel.org, Netdev List <netdev@vger.kernel.org>
Subject: Re: Upcoming 2.6.13 and hostap driver
References: <1958.192.168.0.150.1122549325.squirrel@kone>
In-Reply-To: <1958.192.168.0.150.1122549325.squirrel@kone>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jar wrote:
> Hostap driver has been in the -mm tree for a long time. Any plans to merge it to
> upcoming 2.6.13?

It needs to be merged with the ieee80211 generic layer, before it can go 
upstream.

	Jeff


