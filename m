Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265013AbUD2XBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265013AbUD2XBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 19:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265028AbUD2XBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 19:01:03 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:34828 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265030AbUD2W7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 18:59:11 -0400
Message-ID: <409189D1.9010307@techsource.com>
Date: Thu, 29 Apr 2004 19:03:45 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Marc Boucher <marc@linuxant.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <408F99D5.1010900@aitel.hist.no> <3D29390A-992F-11D8-85DF-000A95BCAC26@linuxant.com> <200404300141.09497.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200404300141.09497.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Denis Vlasenko wrote:

>>Thank you for the advice. However, if you knew our customers and
>>understood their needs better you would realize that these are not
>>feasible options.
> 
> 
> I think you have to live with multiple warning messages,
> at least until Rusty's patch propagate to mainline.
> It's not fatal.


I have to agree.  The only thing that Marc did wrong was to evade the 
tainting.  Everything else seems to be above-board.


