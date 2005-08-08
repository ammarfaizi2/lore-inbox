Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVHHU0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVHHU0v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVHHU0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:26:50 -0400
Received: from crl-mail-dmz.crl.hpl.hp.com ([192.58.210.9]:45713 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S932214AbVHHU0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:26:49 -0400
Message-ID: <42F7BFA5.6090601@hp.com>
Date: Mon, 08 Aug 2005 16:25:09 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jamey@handhelds.org, anpaza@mail.ru
Subject: Re: platform-device-driver-for-mq11xx-graphics-chip.patch added to
 -mm tree
References: <200508050719.j757J9KO032652@shell0.pdx.osdl.net> <1123228133.7649.4.camel@localhost.localdomain> <42F35BAA.1070506@hp.com> <20050808195205.D12788@flint.arm.linux.org.uk>
In-Reply-To: <20050808195205.D12788@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Fri, Aug 05, 2005 at 08:29:30AM -0400, Jamey Hicks wrote:
>  
>
>>I do not have a problem with moving these drivers to drivers/mfd.  I do 
>>want to have a policy that says where such drivers should go.
>>    
>>
>
>Well, I've recently moved the UCB1200/1300 drivers there.  See my reply
>to Pavel yesterday.
>
>  
>
Sounds good. I have some other things to fix on this driver, and in the 
process will move it to drivers/mfd.

Jamey

