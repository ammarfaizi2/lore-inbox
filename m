Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264331AbUEMRlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbUEMRlP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264344AbUEMRkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:40:32 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:63935 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S264331AbUEMRkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:40:13 -0400
Date: Thu, 13 May 2004 11:41:16 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Message-ID: <20040513174116.GA9868@bounceswoosh.org>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	Robert Hancock <hancockr@shaw.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <fa.jr282gn.1ni2t37@ifi.uio.no> <008201c437e7$b1a35160$6601a8c0@northbrook> <20040512185224.GA2658@bounceswoosh.org> <200405121728.22629.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <200405121728.22629.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12 at 17:28, Gene Heskett wrote:
>Thank you Eric, for such a clear explanation of the problem (I have 
>one of those drives and was the one who made the second report I 
>believe...  Now it seems that a fix can be written into our driver 
>without a lot of fuss, so it becomes a non-issue for us once thats 
>filtered thru Andrew and on up to Linus.

Glad I could help.  As I said in a private email to a few people, I
fixed this for all future drives this morning, so that wierdness
shouldn't show up again.  If anyone notices anything wierd or has
questions, I'd be happy to hear about it and try to help.

>My Q for you, is, does M$ already have a similar workaround in their 
>drivers?  Just curious. :)

I am not privy to any "M$" driver code so I have no idea what is in
their driver.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

