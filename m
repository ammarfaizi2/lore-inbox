Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTFIP6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 11:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTFIP6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 11:58:23 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:32210 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S264488AbTFIP6W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 11:58:22 -0400
Message-ID: <3EE4B4C3.80902@techsource.com>
Date: Mon, 09 Jun 2003 12:24:35 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write
 can block)
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk> <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com> <20030607001202.GB14475@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:
> On Wed, Jun 04, 2003 at 11:21:41AM -0400, Timothy Miller wrote:
> 
>>Perhaps it would be good to have an explanation for the relative 
>>importance of placing braces and else on the same line as compared to 
>>other formatting standards.
> 
> 
> Please read Documentation/CodingStyle.
> 
> If you want more justification, read my OLS 2001 paper.
> 


Well, the coding style you propose isn't exactly the way I do things 
(although it's pretty close).  For instance, I'm not accustomed to using 
a single tab character for indent.  Having more experience with X11 
internals than Linux, you can see where I would get my four-space indent 
habit from.  No matter.  I can easily adapt.

One thing I wanted to mention, however, is that your tongue-in-cheek 
style doesn't help you.  Coding style is something that needs to be 
taken seriously when you're setting standards.

