Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266484AbUHVXWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266484AbUHVXWS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 19:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUHVXWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 19:22:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60127 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266484AbUHVXWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 19:22:14 -0400
Message-ID: <41292A9A.4010007@pobox.com>
Date: Sun, 22 Aug 2004 19:22:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Fraser <paul@fraser.ipv6.net.au>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: Trivial IPv6-for-Fedora HOWTO
References: <4129236E.9020205@pobox.com> <4129276A.4090001@fraser.ipv6.net.au>
In-Reply-To: <4129276A.4090001@fraser.ipv6.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fraser wrote:
> You can also get an IPv6 tunnel at http://tunnelbroker.ipv6.net.au/ that 
> will give you your own IPv6 tunnel and allocation. This isn't just an 
> Australian site either - you can get either AU or US tunnels, and you 
> can apply and use it anywhere in the world.


Agreed, but the point of my post (and 6to4 in general) is that -- like 
the general theme of IPv6 itself -- using 6to4 under Fedora Core 2 works 
automatically.  No need to worry about logging into a tunnel broker, and 
no need to worry about traffic with other 6to4 sites being sub-optimally 
routed.

	Jeff


