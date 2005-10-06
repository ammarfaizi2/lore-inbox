Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVJFJSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVJFJSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 05:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVJFJSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 05:18:49 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:26340 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750757AbVJFJSt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 05:18:49 -0400
Message-ID: <4344EC64.2010400@aitel.hist.no>
Date: Thu, 06 Oct 2005 11:20:36 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Helge Hafting <helgehaf@aitel.hist.no>, Emmanuel Fleury <fleury@cs.aau.dk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: freebox possible GPL violation
References: <20051005111329.GA31087@linux.ensimag.fr> <4343B779.8030200@cs.aau.dk> <1128511676.2920.19.camel@laptopd505.fenrus.org> <4343BB04.7090204@cs.aau.dk> <1128513584.2920.23.camel@laptopd505.fenrus.org> <4343C0DB.9080506@cs.aau.dk> <1128514062.2920.27.camel@laptopd505.fenrus.org> <4343C73E.9000507@cs.aau.dk> <20051006000741.GC18080@aitel.hist.no> <Pine.LNX.4.62.0510051741310.14560@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0510051741310.14560@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> On Thu, 6 Oct 2005, Helge Hafting wrote:
>
>> If the box downloads a linux kernel through the DSLAM network, then
>> someone is clearly distributing linux kernels through the DSLAM network.
>> I would guess it is the same guys, because relying on someone else 
>> providing
>> them with kernels is a risky business.  But whoever is on the other end
>> of the DSLAM net have to offer the source as well, because they _are_
>> distributing kernels.
>>
>> The fact that the user isn't supposed to know how this box work
>> doesn't change anything, of course.  The GPL says those who
>> distribute the work - it doesn't matter that they don't tell the
>> customer that they're given a linux kernel. They still have to offer
>> the source if asked.
>
>
> the argument that they are making is that they are only moveing the 
> kernel within their own companies equipment, and therefor it doesn't 
> count as 'distribution'

Interesting argument, but it breaks for at least two reasons:
1. You can buy that box instead of just hiring it. That moves kernels 
"outside the company",
    for money even.
2. It doesn't matter if they only move kernels withing their own 
companys equipment.
    If they lend a customer equipment containing a linux kernel, then 
they're lending
    them a linux kernel.  Lending is distribution!

>
> agree with this argument or not, but please acknowledge this point of 
> view rather then pretending that they have no argument at all and are 
> just plain refusing.

The argument might be fine, if they were moving linux kernels into 
company equipment
used by company personell only.  (I.e. linux-powered 
desktops/servers/gadgets for their employees.)
And it might not.  Maybe they actually have to distribute source to 
employees too, if they
request it.  The GPL only mentions recipients, no exceptions for 
"internal company use".  A company
may perhaps demand that the employees never request the source, though. 
Or perhaps
"internal use" is covered by the company being a "legal unit".

People breaking the GPL should be taken seriously.  Fortunately, the 
solution is easy for
GPL-breakers.  Break someone else's license, and they have to pay 
damages.  Break the GPL,
and all you need to do is to stuff some source code onto a public 
(web/ftp)server - and all is fine again.

The situation is so cheap and _easy_ to rectify, that is one reason 
people gets so pissed off at
a violation.  It is not as if complying with the GPL would be any kind 
of burden to them.

Helge Hafting
