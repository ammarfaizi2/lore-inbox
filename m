Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVCNRAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVCNRAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVCNRAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:00:55 -0500
Received: from fire.osdl.org ([65.172.181.4]:56004 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261263AbVCNRAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:00:47 -0500
Message-ID: <4235C333.4060006@osdl.org>
Date: Mon, 14 Mar 2005 09:00:35 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
CC: David Vrabel <dvrabel@cantab.net>, long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       greg@kroah.com
Subject: Re: [PATCH 1/6] PCI Express Advanced Error Reporting Driver
References: <C7AB9DA4D0B1F344BF2489FA165E50240803A13E@orsmsx404.amr.corp.intel.com>
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E50240803A13E@orsmsx404.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nguyen, Tom L wrote:
> Monday, March 14, 2005 3:01 AM David Vrabel wrote:
> 
> 
>>>This patch includes PCIEAER-HOWTO.txt, which describes how the PCI
>>>Express Advanced Error Reporting Root driver works.
>>>
>>>--- linux-2.6.11-rc5/Documentation/PCIEAER-HOWTO.txt
>>>
>>
>>Could this be placed in a sub-system subdirectory (creating one if
>>necessary, e.g., pci/)?  The root of Documentation/ is rather full of
>>random files as is.
> 
> 
> Most of the HOWTO documents are under Documentation/ directory. I have
> no problem of placing it in a sub-system subdirectory if it is OK with
> Linux community?

It should remain in the Documentation/ directory or a (new)
subdirectory under Documentation/ .

-- 
~Randy
