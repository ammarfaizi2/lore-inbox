Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVEJUtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVEJUtS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 16:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVEJUqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 16:46:06 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:33231 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261795AbVEJUpL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 16:45:11 -0400
Message-ID: <42811D51.1030106@tiscali.de>
Date: Tue, 10 May 2005 22:45:05 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Eisenbach <int2str@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: High res timer?
References: <7f800d9f050510132762f0ee7@mail.gmail.com>
In-Reply-To: <7f800d9f050510132762f0ee7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Eisenbach wrote:
> Hello!
> 
> We're currently using pth_usleep() as a timer for a userspace audio
> application. However, it doesn't seem very accurate and reliable. Is
> there a better (more accurate) timer that we can call form a userspace
> application?
> 
> Thanks,
>     Andre
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
What about nanosleep ()?

Matthias-Christian
