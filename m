Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbSIXHTB>; Tue, 24 Sep 2002 03:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbSIXHTB>; Tue, 24 Sep 2002 03:19:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16141 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261596AbSIXHTA>;
	Tue, 24 Sep 2002 03:19:00 -0400
Message-ID: <3D9012FB.7040700@pobox.com>
Date: Tue, 24 Sep 2002 03:23:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC} 3 of 4 - New problem logging macros, plus template
 generation
References: <20020924070706.D3A332C189@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3D9000B9.4000001@pobox.com> [Jeff Garzik] write[s]:
>>Changing every printk() in the damn kernel?
>>Come on dude, I _know_ you have more taste than that.
> 
> I'm not interested in changing all the printks.  I'm interested in
> designing the simplest regularized logging interface I can.  If it's
> done right, driver authors will migrate to it because it's easier for
> them, and their bug reports become clearer, and sysadmins get happier.


Thanks for saying that out loud.

So, IOW, IBM makes the API, and expects everyone else to step up and do 
the huge amount of grunt work...  Nice.

"If it's done right," there need not be massive changes at all.
More tomorrow.

	Jeff, just another unpaid IBM worker...



