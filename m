Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUJJAV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUJJAV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 20:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUJJAV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 20:21:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:10409 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267818AbUJJAV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 20:21:26 -0400
Message-ID: <41687FCA.5010907@osdl.org>
Date: Sat, 09 Oct 2004 17:18:18 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check copy_to_user return value in raw1394
References: <Pine.LNX.4.61.0410100208270.2973@dragon.hygekrogen.localhost> <Pine.LNX.4.61.0410100220580.2973@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0410100220580.2973@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On Sun, 10 Oct 2004, Jesper Juhl wrote:
> 
> 
>>Here's a proposed patch to make sure we check the return value of 
>>copy_to_user in raw1394.c::raw1394_read
> 
> 
> 
> Whoops, I made an error when I set the From: address on this mail. If you 
> reply to this then please use juhl-lkml as the address if you want me to 
> see your reply.

How about sending it to:

IEEE 1394 SUBSYSTEM
P:	Ben Collins
M:	bcollins@debian.org
L:	linux1394-devel@lists.sourceforge.net
W:	http://www.linux1394.org/
S:	Maintained

and change "if(" to "if (" ...

-- 
~Randy
