Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbVLEXJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbVLEXJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVLEXJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:09:53 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:26613 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751496AbVLEXJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:09:52 -0500
Message-ID: <43949686.3020300@tmr.com>
Date: Mon, 05 Dec 2005 14:35:34 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>	 <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>	 <20051203201945.GA4182@kroah.com>	 <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com>	 <20051203211209.GA4937@kroah.com>	 <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com>	 <1133645895.22170.33.camel@laptopd505.fenrus.org>	 <f0cc38560512031353q27ee0a2dh70e283f53671b70f@mail.gmail.com>	 <1133682973.5188.3.camel@laptopd505.fenrus.org>	 <f0cc38560512040657i58cc08efqa8596c357fcea82e@mail.gmail.com> <1133709038.5188.49.camel@laptopd505.fenrus.org>
In-Reply-To: <1133709038.5188.49.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2005-12-04 at 15:57 +0100, M. wrote:
> 
> 
>>if distros would align on those 6months versions those less
>>experienced users would get 5 years support on those kernels. 
> 
> 
> no distro gives 5 years of support for a kernel done every 6 months;
> they start such projects more like every 18 to 24 months (SuSE used to
> do it a bit more frequently but it seems they also slowed this down).
> 
> 
>>example: redhat, suse and mandriva are releasing their new product
>>using the latest 6months (or whatever) kernel; they are not going to
>>patch it except for new filesystems or bugfixes because of the new dev
> 
> 
> "except for" is a slipperly slope. And "except for bugfixes" would be
> wrong... those would be the ones that need to be in the kernel.org
> kernel. As well as new hardware support. At which point.. what is the
> difference? Where do 'features' stop and where do 'only needed bugfixes'
> begin?

Given the examples of 2.2 and 2.4 ongoing low level maintenence, I think 
that's a poor objection, a stable series (in the old sense) needs one 
maintainer to make the decisions on what goings in, and typically people 
will do the actualy work cooperating with the primary maintainer.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

