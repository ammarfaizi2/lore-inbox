Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVCXBH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVCXBH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVCXBH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:07:28 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:10576 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262052AbVCXBHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:07:25 -0500
Message-ID: <424212C9.2070006@yahoo.com.au>
Date: Thu, 24 Mar 2005 12:07:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, benh@kernel.crashing.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] freepgt: free_pgtables shakeup
References: <B8E391BBE9FE384DAA4C5C003888BE6F032455F2@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F032455F2@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
>>OK, attached is my first cut at slimming down the boundary tests.
>>I have only had a chance to try it on i386, so I hate to drop it
>>on you like this - but I *have* put a bit of thought into it....
>>Treat it as an RFC, and I'll try to test it on a wider range of
>>things in the next couple of days.
>>
>>Not that there is anything really nasty with your system David,
>>so I don't think it will be a big disaster if I can't get this to
>>work.
>>
>>Goes on top of Hugh's 6 patches.
> 
> 
> Runs on ia64.  Looks much cleaner too.
> 

Oh good. Thanks for testing, Tony.

