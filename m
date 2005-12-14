Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965048AbVLNWrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVLNWrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbVLNWrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:47:10 -0500
Received: from mail.dvmed.net ([216.237.124.58]:50137 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965048AbVLNWrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:47:08 -0500
Message-ID: <43A0A0E6.8030303@pobox.com>
Date: Wed, 14 Dec 2005 17:47:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] FS_NOATIME for ocfs
References: <20051213175646.GD17130@lst.de>
In-Reply-To: <20051213175646.GD17130@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Christoph Hellwig wrote: > Although I think ocfs should
	still go into 2.6.15 a an additional driver > that stands on it's own..
	I ACK the inclusion of ocfs as well, but not in 2.6.15. Standalone or
	not, we don't need to set an example of including new features at the
	last minute. That just encourages other folks to submit new features at
	the last minute. Which leads to lack of review, and unnecessary last
	minute work for some. Do that enough times, and you'll be seeing
	reiser4 sent to Linus 24 hours before each -final release :) [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Although I think ocfs should still go into 2.6.15 a an additional driver
> that stands on it's own..

I ACK the inclusion of ocfs as well, but not in 2.6.15.

Standalone or not, we don't need to set an example of including new 
features at the last minute.  That just encourages other folks to submit 
new features at the last minute.  Which leads to lack of review, and 
unnecessary last minute work for some.  Do that enough times, and you'll 
be seeing reiser4 sent to Linus 24 hours before each -final release :)

	Jeff





