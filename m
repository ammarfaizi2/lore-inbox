Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVALSjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVALSjW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVALSjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:39:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31391 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261232AbVALSjP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:39:15 -0500
Message-ID: <41E56EBB.6030701@pobox.com>
Date: Wed, 12 Jan 2005 13:38:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x: support more ethtool_ops
References: <200501111913.j0BJDnIL009341@hera.kernel.org> <41E42C38.1090903@pobox.com> <20050112154929.GA2738@gareth.mathematik.tu-chemnitz.de>
In-Reply-To: <20050112154929.GA2738@gareth.mathematik.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Klassert wrote:
> But anyway, I will rework this part. 
> What is the expected behavior of get_ethtool_stats()?
> Provide just the NIC specific stats or all stats as the e100 driver does it?


Just the NIC-specific stats.

	Jeff


