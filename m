Return-Path: <linux-kernel-owner+w=401wt.eu-S932724AbXAASLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbXAASLO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 13:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbXAASLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 13:11:14 -0500
Received: from rs27.luxsci.com ([66.216.127.24]:60082 "EHLO rs27.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932731AbXAASLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 13:11:13 -0500
Message-ID: <45994E9F.9040904@firmworks.com>
Date: Mon, 01 Jan 2007 08:10:39 -1000
From: Mitch Bradley <wmb@firmworks.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: segher@kernel.crashing.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
References: <20061231.024917.59652177.davem@davemloft.net>	<20061231154103.GA7409@infradead.org>	<445cb4c27a664491761ce4e219aa0960@kernel.crashing.org> <20070101.005714.35017753.davem@davemloft.net>
In-Reply-To: <20070101.005714.35017753.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Miller wrote:
>
>  We don't generally export binary representation
> files out of /proc or /sys, in fact this rule I believe is layed
> our precisely somewhere at least in the sysfs case.
>
>   
pci-sysfs exports PCI config space in binary.

