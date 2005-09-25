Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVIYMq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVIYMq4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 08:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbVIYMq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 08:46:56 -0400
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:51649 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751284AbVIYMqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 08:46:55 -0400
Message-ID: <43369C2F.3050201@telia.com>
Date: Sun, 25 Sep 2005 14:46:39 +0200
From: Simon Strandman <simon.strandman@telia.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: Ville Herva <v@iki.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Upgrade 2.6.12-rc4 -> 2.6.13.1 broke DVD-R writing (fails consistenly
 in OPC phase)
References: <20050925123049.GA24760@viasys.com>
In-Reply-To: <20050925123049.GA24760@viasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva skrev:

>The .config from 2.6.12-rc4 and 2.6.13.1 is nearly identical, but with
>2.6.13.1 I use HZ=250 (that being the default nowadays) and 
>2.6.13.1 has CONFIG_PREEMPT_VOLUNTARY=y instead of 2.6.12-rc4's
>CONFIG_PREEMPT=y and CONFIG_PREEMPT_BKL=y ².
>
>Any ideas?
>
>  
>
Have you tried with HZ=1000?

-- 
Simon Strandman <simon.strandman@telia.com>

