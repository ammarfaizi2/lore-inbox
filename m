Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270996AbTGPRvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271001AbTGPRvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:51:25 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:5869 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S270996AbTGPRvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:51:15 -0400
Message-ID: <3F15F4AE.3080306@netcabo.pt>
Date: Thu, 17 Jul 2003 01:58:22 +0100
From: Pedro Ribeiro <deadheart@netcabo.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems with 2.6.0-test1 && depmod
References: <3F15E439.70107@netcabo.pt> <20030716103517.65e146bc.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jul 2003 18:01:19.0290 (UTC) FILETIME=[423441A0:01C34BC4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

>On Thu, 17 Jul 2003 00:48:09 +0100 Pedro Ribeiro <deadheart@netcabo.pt> wrote:
>
>| I've just installed 2.6.0-test1 but whenever I try to use depmod, lsmod 
>| or insmod I get this error:
>| 
>| Module                  Size  Used by    Not tainted
>| lsmod: QM_MODULES: Function not implemented
>| 
>| I first noticed this when I was trying to install the nvidia drivers. 
>| Needless to say that I was unable to install them. What can I do to 
>| solve this problem? By the way,
>| 
>| depmod version 2.4.16
>
>Please read
>  http://www.codemonkey.org.uk/post-halloween-2.5.txt
>when it's back online (maybe 2 hours).
>
>Also, you need to use the module-init-tools for 2.6.
>They are at
>  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
>
>--
>~Randy
>  
>
I'm sorry, but what version am I supposed to download? The lastest? 
(module-init-tools-0.9.13-pre.tar.gz)

PR

