Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268823AbUHLV1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268823AbUHLV1d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268806AbUHLVY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:24:28 -0400
Received: from host81-7-2-179.adsl.v21.co.uk ([81.7.2.179]:1666 "EHLO
	hilly.house") by vger.kernel.org with ESMTP id S268798AbUHLVWF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:22:05 -0400
Message-ID: <411BDF73.2090600@vu.a.la>
Date: Thu, 12 Aug 2004 22:21:55 +0100
From: Charlie Brej <brejc8@vu.a.la>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reproducable user mode system hang
References: <411BC339.30504@vu.a.la> <20040812190444.GC23182@logos.cnet>
In-Reply-To: <20040812190444.GC23182@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Can you get any kind of trace (ctrl+sysrq+p or NMI oopser) ? 

I will be able to tell you tomorrow when I get back to work

 > And also make sure to rerun the tests with newer v2.6's.

Well you are right. It seems to be either fixed in the newer kernel or not 
effecting the newer kernel. These two both worked fine with the redhat compiled 
2.6.7:

Linux solem.cs.man.ac.uk 2.6.7-1.517 #1 Wed Aug 11 16:28:33 EDT 2004 i686 athlon 
i386 GNU/Linux
Linux hilly.house 2.6.7-1.517 #1 Wed Aug 11 16:28:33 EDT 2004 i686 i686 i386 
GNU/Linux

Did you have an idea of what was causing this?
-- 
         Charlie Brej
APT Group, Dept. Computer Science, University of Manchester
Web: http://www.cs.man.ac.uk/~brejc8/ Tel: +44 161 275 6844
Mail: IT302, Manchester University, Manchester, M13 9PL, UK
