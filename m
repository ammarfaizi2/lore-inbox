Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVG1TJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVG1TJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVG1TGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:06:12 -0400
Received: from mail.dvmed.net ([216.237.124.58]:7883 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262010AbVG1TFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:05:54 -0400
Message-ID: <42E92C88.9000501@pobox.com>
Date: Thu, 28 Jul 2005 15:05:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Maxey <dwm@maxeymade.com>
CC: Lukasz Kosewski <lkosewsk@nit.ca>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH 0/3] Add disk hotswap support to libata
References: <200507281854.j6SIsJ87006310@falcon30.maxeymade.com>
In-Reply-To: <200507281854.j6SIsJ87006310@falcon30.maxeymade.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Maxey wrote:
> On Thu, 21 Jul 2005 21:35:24 EDT, Jeff Garzik wrote:
> 
>>As soon as I finish SATA ATAPI (this week[end]), I'll take a look at 
>>this.  A quick review of the patches didn't turn up anything terribly 
>>objectionable, though :)
>>
> 
> 
> I would like to offer to test when you are ready.  Some older and new SATAPI 
> drives, various chipsets (ICH{5,6}, TX4 on the way).  And a SATA analyzer 
> for anything really odd. 

Great!

It'll be posted here on linux-ide, so just keep an eye out.

Analysis of any portion of libata, with a SATA analyzer, would be much 
appreciated.

	Jeff


