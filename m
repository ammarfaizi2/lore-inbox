Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVGMBdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVGMBdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVGMBdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:33:50 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:19386 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262430AbVGMBdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:33:18 -0400
Message-ID: <42D47033.6030004@jp.fujitsu.com>
Date: Wed, 13 Jul 2005 10:36:51 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.13-rc1 08/10] IOCHK interface for I/O error handling/detecting
References: <42CB63B2.6000505@jp.fujitsu.com> <42CB69BD.1090607@jp.fujitsu.com> <20050712222203.GG26607@austin.ibm.com>
In-Reply-To: <20050712222203.GG26607@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> On Wed, Jul 06, 2005 at 02:18:53PM +0900, Hidetoshi Seto was heard to remark:
> 
>>+static int pci_error_recovery(peidx_table_t *peidx)
> 
> Minor comment:
> Maybe a different name for this routine would be good;
> this potentially conflicts with generic pci routines.

Good point. I'll fix it.

Thanks,
H.Seto

