Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVDNUlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVDNUlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVDNUlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:41:46 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:24727 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261537AbVDNUlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:41:39 -0400
Message-ID: <425ED57E.4090007@candelatech.com>
Date: Thu, 14 Apr 2005 13:41:34 -0700
From: Ben Greear <greearb@candelatech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: luming.yu@intel.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hard lockup on nx5000 laptop with 2.6.11+hack and FC2's 2.6.10-1.770_FC2
References: <42548FFC.7000004@candelatech.com> <200504141317.28478.luming.yu@intel.com>
In-Reply-To: <200504141317.28478.luming.yu@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yu, Luming wrote:

>Do you have acpi enabled?  
>  
>

Yes, in both of my custom kernels, and probably in the FC2 one as well.

>If the problem just happend with acpi enabled, please
>try latest acpi patch through testing latest mm tree, If it still doesn't 
>work, please file a bug on www.kernel.org
>  
>

I'll try the latest -mm and report back.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


