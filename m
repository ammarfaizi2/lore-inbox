Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTJBX2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 19:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTJBX2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 19:28:23 -0400
Received: from snickers.hotpop.com ([204.57.55.49]:57776 "EHLO
	snickers.hotpop.com") by vger.kernel.org with ESMTP id S263540AbTJBX2V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 19:28:21 -0400
Message-ID: <3F7CA139.3000108@hotpop.com>
Date: Fri, 03 Oct 2003 03:35:45 +0530
From: dacin <dacin@hotpop.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030818
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: reg@dwf.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 - Network doesn't come up.
References: <200310022138.h92Lc67x005420@orion.dwf.com>
In-Reply-To: <200310022138.h92Lc67x005420@orion.dwf.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrade your initscripts from rawhide ...... it will fix it.

regards
<dacodecz>

reg@dwf.com wrote:

>OK, Im trying to run 2.6.0-test6 on top of RH9.
>I have progress in some areas but not others.
>
>NETWORKING. is a nogo.
>
>If I compile the driver 3c59x as a module, it gets loaded, but
>with the driver in the kernel or as a module, I get the messages
>in the messages file (during boot) or when I do a ./network start
>from /etc/rc.d/init.d
>
>---
>
>[root@orion init.d]# ./network* restart
>Shutting down interface eth0:                              [  OK  ]
>Shutting down loopback interface:                          [  OK  ]
>Setting network parameters:                                [  OK  ]
>Bringing up loopback interface:  arping: socket: Address family not supported 
>by protocol
>Error, some other host already uses address 127.0.0.1.
>                                                           [FAILED]
>Bringing up interface eth0:  arping: socket: Address family not supported by 
>protocol
>Error, some other host already uses address 204.134.2.19.
>                                                           [FAILED]
>
>---
>
>                                        Reg.Clemens
>                                        reg@dwf.com
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>



