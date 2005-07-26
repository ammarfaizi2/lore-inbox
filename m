Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVGZBWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVGZBWj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 21:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVGZBWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 21:22:39 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:41078 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261466AbVGZBWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 21:22:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lbJDfTBtOlSnrd1XhI/YT23WnPtkB9p+6pw+p6ZyPfDsNf3GxXI2RteLD/Hev8k8sK5GZpDBWtimNy0V1OZIlAjhoH0zXSbW/uMyYjCOiWTq240oJNwzPPhGclGS349um5nYkGjHnexZOMBuQU5Cv7VqIYcJyRugzftsM7gXIDM=
Message-ID: <42E5904A.9050306@gmail.com>
Date: Mon, 25 Jul 2005 21:22:18 -0400
From: Puneet Vyas <vyas.puneet@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alejandro Bonilla <abonilla@linuxwireless.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM:Machine hangs on pulling out USB cd writer on laptop.
References: <42E58483.2050602@gmail.com> <42E57ACD.8070909@linuxwireless.org> <42E57BD6.4090006@linuxwireless.org>
In-Reply-To: <42E57BD6.4090006@linuxwireless.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla wrote:

>>
> Also, go to a tty (ctrl+alt+f1), login and then unplug the device, If 
> it gives a kernel panic, show the output here.
>
> .Alejandro
>
>
Thanks for looking into this.

I tried the tty and got the following messages in continuous loop (they 
were scrolling past real fast but since there were only two messages 
they kind of overlapped so I could write them down)

ide : failed opcode was : unknown
hdc : status error: status 0x00 { }

Is there anything else that I can provide?

~Puneet

