Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263349AbVCKPKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbVCKPKr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbVCKPKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:10:46 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:45454 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S263379AbVCKPKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:10:16 -0500
Message-ID: <4231B4A4.4050207@g-house.de>
Date: Fri, 11 Mar 2005 16:09:24 +0100
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050212)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Mauricio Lin <mauriciolin@gmail.com>, elenstev@mesatop.com
Subject: Re: oom with 2.6.11
References: <422DC2F1.7020802@g-house.de>	 <3f250c710503090518526d8b90@mail.gmail.com>	 <3f250c7105030905415cab5192@mail.gmail.com>	 <422F016A.2090107@g-house.de> <423063DB.40905@g-house.de> <3f250c7105031101016d7cb08e@mail.gmail.com>
In-Reply-To: <3f250c7105031101016d7cb08e@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Lin wrote:
> Hi Christian,
> 
> I would like to know what are the kernel versions this problem happened.
> 
> Did this problem start from 2.6.11-rc2-bk10?

i noticed it first at 2.6.11, then again with 2.6.11-rc5-bk2. suspecting
pppd to be the culprit to chew up all RAM after being terminated by my ISP
once a day - i just have to wait (must be around 2a.m.).

thanks,
Christian.
-- 
BOFH excuse #134:

because of network lag due to too many people playing deathmatch
