Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbVJXPnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbVJXPnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 11:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVJXPnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 11:43:19 -0400
Received: from mail.dvmed.net ([216.237.124.58]:5321 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751106AbVJXPnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 11:43:18 -0400
Message-ID: <435D010E.2070308@pobox.com>
Date: Mon, 24 Oct 2005 11:43:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ashutosh Naik <ashutosh_naik@adaptec.com>
CC: jeremy@sgi.com, benh@kernel.crashing.org, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata: Fixes several warnings in sata_vsc.c and sata_svw.c
References: <1130150013.16820.66.camel@kir9060.adaptec.com>
In-Reply-To: <1130150013.16820.66.camel@kir9060.adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashutosh Naik wrote:
> This patch fixes several types in sata_vsc.c and sata_svw.c and hence
> fixes tons of compiler warnings.
> 
> Signed-off-by: Ashutosh Naik <ashutosh_naik@adaptec.com>

This patch has been repeatedly NAK'd.  Check the archives...

	Jeff



