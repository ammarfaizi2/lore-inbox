Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVBSKKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVBSKKq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 05:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVBSKKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 05:10:46 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:47542 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261683AbVBSKKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 05:10:40 -0500
Message-ID: <4217109F.2090009@tiscali.de>
Date: Sat, 19 Feb 2005 11:10:39 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: sylvanino b <sylvanino@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: I wrote a kernel tool for monitoring / web page
References: <d14685de050218164127828b06@mail.gmail.com>
In-Reply-To: <d14685de050218164127828b06@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sylvanino b wrote:

>Hi,
>
>I wrote a kernel tool for my personnal usage which goal is to keep a
>record of recent task preemptions and interruptions that appears under
>linux. Although the record is short (a few minutes only), It can help
>to analyse scheduling algorithm efficiency and also driver timing
>issues. The user can access data from user-space, through proc
>filesystem and analyze it with a graphics tool.  Then, since it's also
>availlable within KDB, it can give clues and help for debugging.
>
>So far, the tool is not a big deal, but not trivial either. When It is
>running, the tool doesn't overload the system. And when it is not
>running, it's just transparent.
>
>I did a webpage for it, you can check it out at:
>http://membres.lycos.fr/kernelanalyzer/
>
>If you have any comment/critics, don't hesitate to share it
>Thanks,
>
>Sylvain
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi!
Lycos is not the right place for such a good project, request hosting at 
sf.net or developer.berlios.de.

Matthias-Christian Ott
