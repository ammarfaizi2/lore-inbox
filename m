Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbUD1U0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbUD1U0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUD1UGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:06:11 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:17683 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261611AbUD1T2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:28:40 -0400
Message-ID: <409006E6.5070406@techsource.com>
Date: Wed, 28 Apr 2004 15:32:54 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <1083107550.30985.122.camel@bach> <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com> <1083117450.2152.222.camel@bach> <1EF114FF-98C4-11D8-85DF-000A95BCAC26@linuxant.com> <408F99D5.1010900@aitel.hist.no> <3D29390A-992F-11D8-85DF-000A95BCAC26@linuxant.com>
In-Reply-To: <3D29390A-992F-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marc Boucher wrote:

>> I believe you have to remove the \0 to operate legally (or release the 
>> full source under the GPL for real.)
>> Your customer's problem is fixable though.  Either by also changing 
>> the logging level
>> so the message doesn't go out on the console, or by patching the line 
>> with that printk() out of your customer's kernel.
>> You can do this as a part of your install program.  If it gets too 
>> hard, consider
>> supplying the customer with your own precompiled kernel.
> 
> 
> Thank you for the advice. However, if you knew our customers and 
> understood their needs better you would realize that these are not 
> feasible options.


If your only "options" involve violating the GPL, then you cannot do 
business in this area.  "Someone won't let me release some code" isn't 
an excuse for breaking the law.

