Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbUJYVoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUJYVoc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbUJYVnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:43:52 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:63121 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261279AbUJYVmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:42:25 -0400
Message-ID: <417D73C8.5040204@tmr.com>
Date: Mon, 25 Oct 2004 17:44:40 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
References: <1098485798.6028.83.camel@gaston><Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <1098566710.3872.149.camel@baythorne.infradead.org>
In-Reply-To: <1098566710.3872.149.camel@baythorne.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

> Damn right. If 2.6.10 doesn't boot on the G5 with i8042 and 8250 drivers
> built in, and doesn't sleep (well, more to the point doesn't resume) on
> my shinybook, I shall sulk :)

Suspend is Shakespearean, "to sleep, perchance to dream." I don't know 
why people are still trying the fix suspend, it works perfectly on all 
my machines, I would like to see some work on wake-the-@-up at this point.

The sad part is that using apm and 2.4, all my laptops seem happy to 
sleep and wake when asked. One of the reasons I'm running 2.4 on the old 
ones, the new ones boot fast enought that I don't care.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
