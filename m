Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUHYOpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUHYOpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUHYOpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:45:09 -0400
Received: from jor-l.pns.networktel.net ([216.83.236.236]:15630 "EHLO
	jor-l.pns.networktel.net") by vger.kernel.org with ESMTP
	id S266807AbUHYOou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:44:50 -0400
Message-ID: <412CA4EE.9070908@versaccounting.com>
Date: Wed, 25 Aug 2004 09:40:46 -0500
From: Ben Duncan <ben@versaccounting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: ATAPI (Memory Leak?)
References: <412C18D2.5080206@tuxq.com> <1093409340.5678.16.camel@krustophenia.net>
In-Reply-To: <1093409340.5678.16.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.27.0.4; VDF 6.27.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As of yet (Set bugzilla # 3263), It is still BORKEN. This is WITH
all the patches applied.


Lee Revell wrote:
> On Wed, 2004-08-25 at 00:42, Steven E. Woolard wrote:
> 
> 
>>If this has been fixed in an rc or mm patch, let me know--I'll upgrade
>>As for now, I'm back on 2.6.7
>>
> 
> 
> You don't say which kernel you are using, but this is a known bug.  It
> should be fixed in 2.6.9.  Try 2.6.9-rc1 for the time being.
> 
> Lee
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Ben Duncan   - VersAccounting Software LLC 336 Elton Road  Jackson MS, 39212
"Never attribute to malice, that which can be adequately explained by stupidity"
        - Hanlon's Razor

