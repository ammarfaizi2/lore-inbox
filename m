Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbULZSC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbULZSC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbULZSC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:02:27 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:57752 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261716AbULZSCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:02:24 -0500
Subject: Re: Dhcp: Ip length 44 disagrees with bytes received 46.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Falk <oliver@linux-kernel.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200412260631.iBQ6VZTk027678@pils.linux-kernel.at>
References: <200412260631.iBQ6VZTk027678@pils.linux-kernel.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104080301.15994.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 16:58:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-12-26 at 06:31, Oliver Falk wrote:
> Hi lkml!
> 
> Maybe it's not good to ask the lkml, but since there are so many experts
> here, it makes sense to me.
> 
> I have a dhcp-server running with 2.6.10 (had it running with
> 2.6.{1,2,3,4,5,6,7,8,9} as well) and the dhcpd logs all the time:
> 
> <snip>
> Dec 26 07:22:11 brain dhcpd: ip length 44 disagrees with bytes received 46.
> Dec 26 07:22:11 brain dhcpd: accepting packet with data after udp payload.

What ethernet card ?

