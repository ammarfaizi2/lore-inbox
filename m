Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVL3OJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVL3OJK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 09:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVL3OJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 09:09:10 -0500
Received: from xizor.is.scarlet.be ([193.74.71.21]:31144 "EHLO
	xizor.is.scarlet.be") by vger.kernel.org with ESMTP id S932123AbVL3OJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 09:09:08 -0500
Message-ID: <43B54021.5000902@kefren.be>
Date: Fri, 30 Dec 2005 15:11:45 +0100
From: Ochal Christophe <ochal@kefren.be>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
References: <43B53EAB.3070800@ns666.com>
In-Reply-To: <43B53EAB.3070800@ns666.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trilight wrote:

>Hiya,
>
>I'm using the 2.6.14.5 kernel and i notice that the system freezes
>sometimes, within 24 hours usually, a total freeze, no mouse/keyb
>reaction. Also i notice that apps crash randomly sometimes.
>
>What can i do to investigate this ?
>
>(none of the above problems occur when windows XP pro is used)
>
>Thanks
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>
I'd start running memtestx86, just to be sure that there's no bad 
memory, i've had a simular problem & turned out i had a defective memory 
dimm. The problem didn't show up in windows in the same manner as it did 
in linux.
