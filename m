Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWIVA7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWIVA7V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWIVA7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:59:21 -0400
Received: from mail.tmr.com ([64.65.253.246]:43160 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S932151AbWIVA7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:59:20 -0400
Message-ID: <45133666.2060601@tmr.com>
Date: Thu, 21 Sep 2006 21:03:34 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19 -mm merge plans
References: <20060920135438.d7dd362b.akpm@osdl.org> <45121382.1090403@garzik.org> <20060920220744.0427539d.akpm@osdl.org> <1158830206.11109.84.camel@localhost.localdomain> <Pine.LNX.4.64.0609210819170.4388@g5.osdl.org> <20060921105959.a55efb5f.akpm@osdl.org> <Pine.LNX.4.64.0609211106391.4388@g5.osdl.org> <45130533.2010209@tmr.com> <45130527.1000302@garzik.org>
In-Reply-To: <45130527.1000302@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Bill Davidsen wrote:
>> I think it would help if you went back to using meaningful names for 
>> releases, because 2.6.19-test1 is pretty clearly a test release even 
>> to people who can't figure out if a number is odd or even. Then after 
>> people stop reporting show stoppers, change to rc numbers, where rc 
>> versions are actually candidates for release without known major bugs.
> 
> 
> Actually, considering our group of developers, I think "-rc" has been 
> remarkably successful at staying on the "bug fixes only" theme.
> 
Perhaps I misread what Linus said, the issue I was suggesting be 
addressed was one of clarity to the testers, not the developers. The 
releases identified as test would be for evaluation, while the ones 
identified as rc would really be candidates with no "fix before next 
version" bugs known. I  would think that between test releases some bugs 
could be fixed, but new features could be added. That would encourage 
more active testing without overly slowing the development process.

Having used that for a long time for 2.2 and 2.4 I think there's quite a 
track record of that nomenclature being clear to the users.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
