Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVBQSyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVBQSyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 13:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVBQSyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 13:54:41 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:18667 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261176AbVBQSyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 13:54:33 -0500
Message-ID: <4214E829.8040202@comcast.net>
Date: Thu, 17 Feb 2005 10:53:29 -0800
From: Nick Winlund <nwinlu@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Adrian Bunk <bunk@stusta.de>, Benjamin LaHaise <bcrl@kvack.org>,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill include/linux/eeprom.h
References: <20050217144825.GJ24808@stusta.de> <4214E419.5060807@pobox.com>
In-Reply-To: <4214E419.5060807@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree eeprom is memory technology at the least there should be 
secondary links for a static or symlinked file that leaves PCI/AT boot 
devices, future PLOS open to development.

Nick

> I would rather update other drivers to use it :)
> 
>     Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

