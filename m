Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWARCl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWARCl1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWARCl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:41:27 -0500
Received: from stinky.trash.net ([213.144.137.162]:12691 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S964840AbWARCl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:41:26 -0500
Message-ID: <43CDAA9E.7010102@trash.net>
Date: Wed, 18 Jan 2006 03:40:30 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Netdev List <netdev@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: net 2.6.16-rc1: multiple ipv6 failures
References: <43CDAA58.5000904@pobox.com>
In-Reply-To: <43CDAA58.5000904@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Just moved my firewall/gateway from 2.6.15 to 2.6.16-rc1, and had a
> couple IPv6-related problems really bite me.

The fix just went in Linus' tree ([IPV6]: Preserve procfs IPV6 address
output format).
