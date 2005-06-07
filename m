Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVFGSv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVFGSv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 14:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVFGSv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 14:51:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41166 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261954AbVFGSul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 14:50:41 -0400
Message-ID: <42A5EC7C.4020202@pobox.com>
Date: Tue, 07 Jun 2005 14:50:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.12-rc6-mm1 & Chelsio driver
References: <20050607181300.GL2369@mail.muni.cz>
In-Reply-To: <20050607181300.GL2369@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:
> Hello,
> 
> should chelsio 10GE driver work in this kernel? If I do modprobe cxgb, then it
> silently returns. No messages in log (dmesg) nor terminal and no new ethX 
> device is discoverred.

I suppose you have Chelsio hardware?

	Jeff



