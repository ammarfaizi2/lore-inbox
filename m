Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWA1RkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWA1RkG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 12:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWA1RkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 12:40:03 -0500
Received: from mail.dvmed.net ([216.237.124.58]:36041 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751489AbWA1RkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 12:40:00 -0500
Message-ID: <43DBAC64.1070902@pobox.com>
Date: Sat, 28 Jan 2006 12:39:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Kosewski <lkosewsk@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc7-git3 1/3] sata_promise: add correct read/write
 of hotplug registers for SATAII devices
References: <355e5e5e0512291523h508fe0c8j459a9377d52d5529@mail.gmail.com>
In-Reply-To: <355e5e5e0512291523h508fe0c8j459a9377d52d5529@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Lukasz Kosewski wrote: > This patch adds support for
	correctly masking out and knowing about > hotplug events on Promise
	SATAII150 Tx4/Tx2 Plus controllers. > > Signed-off-by: Luke Kosewski
	<lkosewsk@gmail.com> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> This patch adds support for correctly masking out and knowing about
> hotplug events on Promise SATAII150 Tx4/Tx2 Plus controllers.
> 
> Signed-off-by:  Luke Kosewski <lkosewsk@gmail.com>

applied


