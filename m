Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVDEOhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVDEOhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVDEOhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:37:20 -0400
Received: from hades.almg.gov.br ([200.198.60.36]:55530 "EHLO
	hades.almg.gov.br") by vger.kernel.org with ESMTP id S261761AbVDEOhL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:37:11 -0400
Message-ID: <4252A2A4.2080705@almg.gov.br>
Date: Tue, 05 Apr 2005 11:37:24 -0300
From: Humberto Massa <humberto.massa@almg.gov.br>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050224)
MIME-Version: 1.0
To: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
References: <ea-O2D.A.6pD.MWoUCB@murphy>
In-Reply-To: <ea-O2D.A.6pD.MWoUCB@murphy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>We do not add comments to the kernel source code which simply state the 
>obvious.
>
>	Jeff
>  
>
Whoa, kind of harsh, isn't it? I'm just trying to help.

Anyway, the problem at hand is: people do *not* think there is anything 
obvious.

For instance: many, many people do not consider binary hexdumps in .c/.h 
files as source code; if you think so, you should state it in writing, 
you know, to avoid lawyer attacks.

Another example: if you think it's obvious that the binary hexdump is 
another work, aggregated to the GPL'd .c/.h file, then you should state 
(again, in writing) which are the licensing terms of said work... 
otherwise, no-one has a written license to redistribute it, leading 
to... lawyer attacks.


HTH,

Massa

