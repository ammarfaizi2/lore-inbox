Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVI2RLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVI2RLs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 13:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbVI2RLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 13:11:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:56300 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932266AbVI2RLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 13:11:47 -0400
Message-ID: <433C204C.7010602@pobox.com>
Date: Thu, 29 Sep 2005 13:11:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Arjan van de Ven <arjan@infradead.org>, Willy Tarreau <willy@w.ods.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com>	 <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com>	 <433AFEB2.7090003@adaptec.com> <433B0457.7020509@pobox.com>	 <433B14E1.6080201@adaptec.com> <433B217F.4060509@pobox.com>	 <20050929040403.GE18716@alpha.home.local> <1127979848.2918.7.camel@laptopd505.fenrus.org> <433C0398.4040302@adaptec.com> <433C0641.3030101@pobox.com> <433C1CA1.3080007@adaptec.com>
In-Reply-To: <433C1CA1.3080007@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> On 09/29/05 11:20, Jeff Garzik wrote:
> 
>>>Arjan, I'll be your best friend here:
>>>Never say this in public or in an intervew.
>>
>>
>>It's hard-earned experience.  We constantly have to teach hardware 
>>vendors how to write good drivers.
> 
> 
> I'm sure you have.  Hardware vendors are lost without
> Jeff, James Bottomley and Christoph.
> 
> You see, it is because of your _enormous_ ego as shown
> above, that the code is being blocked.

No, I was referring to things such as, e.g.
	http://people.redhat.com/arjanv/olspaper.pdf
	http://people.redhat.com/arjanv/OLS.pdf

It has nothing to do with ego, just hard-won experience.

There are bunches of hardware vendors who have their patches merged 
immediately after posting.  They get it.  They have internalized the 
reasons why Linux drivers look the way they do.


>>As a tangent, I already have a design for a Linux filesystem that makes 
>>use of SCSI object-based storage (to James's horror, no doubt :)).  It's 
>>a fun thing to ponder.
> 
> 
> Ok, so the way I see it you want to show who has got
> the bigger balls?
> 
> Jeff, I have *worked* on a Linux OBD-based filesystem.
> 
> Are you going to stop this self-gratifying stuff?

Oh good grief.  It was an example, silly.  Trying to lighten the mood, even.

	Jeff


