Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264771AbUDWJLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264771AbUDWJLL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 05:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUDWJLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 05:11:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:46771 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264771AbUDWJLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 05:11:06 -0400
X-Authenticated: #4512188
Message-ID: <4088DDA6.70508@gmx.de>
Date: Fri, 23 Apr 2004 11:11:02 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040413)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: a.verweij@student.tudelft.nl
CC: Len Brown <len.brown@intel.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, ross@datscreative.com.au,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <Pine.GHP.4.44.0404231100220.21279-100000@elektron.its.tudelft.nl>
In-Reply-To: <Pine.GHP.4.44.0404231100220.21279-100000@elektron.its.tudelft.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjen Verweij wrote:
> He even filed a bug report:
> 
> http://bugme.osdl.org/show_bug.cgi?id=2552
> 
> I don't have access to my box atm, but I will certainly be trying a
> vanilla kernel built with SMP to see what's going on.

Ok, I read the bug report, so it ssems it will still lock-up from my 
silicon image sata controller, but not from PATA internal ide. Well, I 
only tried the sata, but I don't quite understand what makes the 
difference...at least no go for me.

Prakash


