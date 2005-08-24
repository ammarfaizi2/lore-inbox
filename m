Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVHXRAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVHXRAP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 13:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbVHXRAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 13:00:15 -0400
Received: from mail-ash.bigfish.com ([206.16.192.253]:12879 "EHLO
	mail61-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751187AbVHXRAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 13:00:13 -0400
X-BigFish: V
Message-ID: <430CA795.6070607@am.sony.com>
Date: Wed, 24 Aug 2005 10:00:05 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: raja <vnagaraju@effigent.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: delay
References: <430C1772.4030308@effigent.net>
In-Reply-To: <430C1772.4030308@effigent.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

raja wrote:
> Hi,
>     Would you please tell me how to write a function that generates a 
> delay of Less than a sec.(ie for 1 milli se or one microsec etc).

See udelay() (follow the trail from: include/linux/delay.h)

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

