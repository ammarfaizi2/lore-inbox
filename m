Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVCVUpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVCVUpT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVCVUpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:45:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58065 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261957AbVCVUoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:44:10 -0500
Message-ID: <4240838B.5020901@pobox.com>
Date: Tue, 22 Mar 2005 15:43:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Gaston <jason.d.gaston@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA AHCI correction Intel ICH7R - 2.6.11
References: <200503071216.24530.jason.d.gaston@intel.com>
In-Reply-To: <200503071216.24530.jason.d.gaston@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Gaston wrote:
> This patch removes an invalid DID for Intel ICH7R from the ahci.c SATA AHCI driver.
> If acceptable, please apply.

Applied.

For future patches, please put the kernel version ("- 2.6.11" in this 
case) into the subject line, as described in rule #1 at

	http://linux.yyz.us/patch-format.html

Thanks,

	Jeff


