Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTLBVT0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 16:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTLBVT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 16:19:26 -0500
Received: from smtp5.hy.skanova.net ([195.67.199.134]:64967 "EHLO
	smtp5.hy.skanova.net") by vger.kernel.org with ESMTP
	id S264374AbTLBVTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 16:19:01 -0500
Message-ID: <3FCD01C2.2020107@myrealbox.com>
Date: Tue, 02 Dec 2003 22:18:58 +0100
From: Jonathan Fors <etnoy@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031124
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: Jin Suh <jinssuh@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test11]: It doesn't boot with a bootcd
References: <20031202203648.64084.qmail@web41201.mail.yahoo.com>
In-Reply-To: <20031202203648.64084.qmail@web41201.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jin Suh wrote:

>Hi,
>
>I've been trying to build a bootcd with 2.6.0-test11 but it doesn't boot either
>with framebuffer or without framebuffer. I also tried 2.6.0-testX-mm[1,2] but
>same problems. I could make it work on test6 with no framebuffer once. But
>test7 to test11 never worked. My bootcd works fine with 2.4.20. I upgraded
>bin-utils, linux-utils, other tools and  libraries to use 2.6.0 following the
>Documentation/Changes file. My kernel config file is nothing special. It is
>based on 2.4.20 and added few things like XFS. I used to see Oops crashes but I
>don't see those any more but it stops in middle of booting and hangs. If any
>bootcd builders are out there and have any experiences on 2.6.0-testx, please
>let me know. Thanks in advance!
>
>Jin
>
>
>__________________________________
>Do you Yahoo!?
>Free Pop-Up Blocker - Get it now
>http://companion.yahoo.com/
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
Jin, when does the hang during the boot occur?

Jonathan

