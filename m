Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTBNRlR>; Fri, 14 Feb 2003 12:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbTBNRlQ>; Fri, 14 Feb 2003 12:41:16 -0500
Received: from [208.0.185.14] ([208.0.185.14]:58377 "EHLO ncbdc.bbs.com")
	by vger.kernel.org with ESMTP id <S263215AbTBNRlQ>;
	Fri, 14 Feb 2003 12:41:16 -0500
Message-ID: <057889C7F1E5D61193620002A537E8690B5A2D@NCBDC>
From: Larry Hileman <LHileman@snapappliance.com>
To: "'Tomas Szepe'" <szepe@pinerecords.com>,
       Larry Hileman <LHileman@snapappliance.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Question about 48 bit IDE on 2.4.18 kernel
Date: Fri, 14 Feb 2003 09:51:06 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was asked to figure a way to get us over the 137G barrier on
the 2.4.18 kernel.  Going to 2.4.20/21 can be done in parallel
and I will explain this.

Moving to 2.4.20/21 is a large effort here.  If I need to implement
the larger drives in 2.4.18, I'd like to make sure that this
has not already been done and that I have the latest code.


-----Original Message-----
From: Tomas Szepe [mailto:szepe@pinerecords.com]
Sent: Friday, February 14, 2003 9:43 AM
To: Larry Hileman
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about 48 bit IDE on 2.4.18 kernel


> [LHileman@snapappliance.com]
> 
> Ok, from this information it would seem that the 2.4.18 kernel
> will not support > 137G drives?  

Is there any reason why you couldn't upgrade to 2.4.20?

-- 
Tomas Szepe <szepe@pinerecords.com>
