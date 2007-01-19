Return-Path: <linux-kernel-owner+w=401wt.eu-S964780AbXASDGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbXASDGG (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 22:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbXASDGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 22:06:06 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47696 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964782AbXASDGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 22:06:04 -0500
Message-ID: <45B03595.2030604@pobox.com>
Date: Thu, 18 Jan 2007 22:05:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: netdev@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove the broken OAKNET driver
References: <20070104185330.GG20714@stusta.de>
In-Reply-To: <20070104185330.GG20714@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The OAKNET driver:
> - has been marked as BROKEN for more than two years and
> - is still marked as BROKEN.
> 
> Drivers that had been marked as BROKEN for such a long time seem to be
> unlikely to be revived in the forseeable future.
> 
> But if anyone wants to ever revive this driver, the code is still
> present in the older kernel releases.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

applied


