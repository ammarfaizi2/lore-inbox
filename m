Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUHDIRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUHDIRa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 04:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUHDIRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 04:17:30 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:38326 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261232AbUHDIR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 04:17:29 -0400
Message-ID: <41109B96.4040400@free.fr>
Date: Wed, 04 Aug 2004 10:17:26 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040618
X-Accept-Language: en
MIME-Version: 1.0
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Greg KH <greg@kroah.com>, phil@netroedge.com,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Small fix to make i2c-viapro.c work on ASUS A7V with ACPI enabled
References: <B44D37711ED29844BEA67908EAF36F037BB96A@pdsmsx401.ccr.corp.intel.com>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F037BB96A@pdsmsx401.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li, Shaohua wrote:
> Hi,
> I have made a patch for this issue. It's at http://bugme.osdl.org/show_bug.cgi?id=3049

Nice to know a working patch has been proposed already (alltough not yet 
included in 2.6.8-rc2-mm2 and thus not _really_ fixed). I tested the 
(bugme.osdl.org) proposed patch  and I confirm it works well also on my 
similar but not identical motherboard.

When I see the amount of diverses/stupids anwers I've seen on the 
lm-sensors support page for this same problem on many ASUS A7XXX 
motherboard (http://www2.lm-sensors.nu/~lm78/support.html), I'm glad I 
posted on LKML even with a wrong/hacked fix to get the good one.

Thanks Shaohua,

--eric
