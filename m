Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268717AbUI3FEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268717AbUI3FEu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 01:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUI3FEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 01:04:50 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:54698 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S268717AbUI3FEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 01:04:47 -0400
Date: Wed, 29 Sep 2004 22:03:40 -0700
From: Tom Duffy <Tom.Duffy@Sun.COM>
Subject: Re: Linux 2.6.9-rc3
In-reply-to: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <415B93AC.3010502@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, this 2.6.9 cycle is getting too long, but here's a -rc3 and hopefully 
> we're getting there now.

   CC [M]  drivers/isdn/capi/capi.o
/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c: In function 
`handle_minor_send':
/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:538:
warning: cast from pointer to integer of different size
/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c: In function 
`capi_recv_message':
/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
error: `tty' undeclared (first use in this function)
/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
error: (Each undeclared identifier is reported only once
/build1/tduffy/linux-2.6.9-rc3/drivers/isdn/capi/capi.c:649:
error: for each function it appears in.)
make[4]: *** [drivers/isdn/capi/capi.o] Error 1
make[3]: *** [drivers/isdn/capi] Error 2
make[2]: *** [drivers/isdn] Error 2
make[1]: *** [drivers] Error 2
make: *** [_all] Error 2
