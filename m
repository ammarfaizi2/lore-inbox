Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267507AbUHVPu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267507AbUHVPu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbUHVPu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:50:26 -0400
Received: from legaleagle.de ([217.160.128.82]:59593 "EHLO www.legaleagle.de")
	by vger.kernel.org with ESMTP id S267507AbUHVPuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:50:22 -0400
Message-ID: <4128C0BB.9060503@trash.net>
Date: Sun, 22 Aug 2004 17:50:19 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Voluspa <lista4@comhem.se>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.8-rc4-bk1 problem: unregister_netdevice: waiting for ppp0
References: <200408221504.i7MF4Z719895@d1o404.telia.com>
In-Reply-To: <200408221504.i7MF4Z719895@d1o404.telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Voluspa wrote:

>Greetings,
>
>NOTE
>I wrote the text below just prior to the posting of
>01-2.6-cbq-leaks.diff but applying it doesn't change the
>situation here. I still get the same Oops as below. Slight
>changes in memory address but the Call Trace is identical.
>So, different problem?
>ENDNOTE
>
Yes, your problem is a different one, but looks related to
the one in the thread "Oops: Process zebra, EIP is at
fib_create_info+0x22b/0x580".

Regards
Patrick
