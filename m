Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUH0Uht@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUH0Uht (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267584AbUH0Ucy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:32:54 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:50388 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S266756AbUH0UaT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:30:19 -0400
Message-ID: <412F99CE.2070906@blue-labs.org>
Date: Fri, 27 Aug 2004 16:30:06 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040825
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kenneth Lavrsen <kenneth@lavrsen.dk>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Summarizing the PWC driver questions/answers
References: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
In-Reply-To: <6.1.2.0.2.20040827215445.01c4ddb0@inet.uni2.dk>
Content-Type: multipart/mixed;
 boundary="------------080607010608070208070600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080607010608070208070600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm going to be short and simple.

You're making a huge fuss over this.  You're making wild claims about 
being forced to throw away $2000 worth of cameras, the next great thing 
that Linus will toss out of the kernel, companies being hurt, and 10,000 
or more people being put out.

Here are a few points to consider Kenneth;

- Maintain the PWC support yourself
- Stay with the last kernel that supported PWC
- Maintain a patch that puts PWC support into the kernel
- Since the NDA has long since expired, why not investigate using the 
whole of the code?

I would also consider the ramifications of a business model that uses 
bleeding edge releases of kernels for their customers.  You're so upset 
and maddened by what has happened, that you've lost focus on what is 
going on.

The hook wasn't right.  It goes against policy of the kernel.  Putting 
off dealing with it is a slippery slope.

The reaction from the PWC camp seems to be wholly heated and with little 
logical discussion.  Before you turn your flamethrower on me, I also 
have two cameras.  Doing things the Right Way is better, I really don't 
want to be moving the lines every time something doesn't suit me perfectly.

-david
p.s. If you feel like throwing away two grand worth of cameras, feel 
free to ship them to me.  I'm sure my trashcan would enjoy the use of them.

--------------080607010608070208070600
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------080607010608070208070600--
