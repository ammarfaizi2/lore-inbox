Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWH1QZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWH1QZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWH1QZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:25:38 -0400
Received: from mga06.intel.com ([134.134.136.21]:13063 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751175AbWH1QZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:25:37 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,176,1154934000"; 
   d="scan'208"; a="116222451:sNHT41339116"
Message-ID: <44F318F8.3050100@linux.intel.com>
Date: Mon, 28 Aug 2006 18:25:28 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jesse Barnes <jesse.barnes@intel.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       dwalker@mvista.com
Subject: Re: [PATCH] maximum latency tracking infrastructure (version 3)
References: <1156780080.3034.207.camel@laptopd505.fenrus.org> <200608280925.34326.jesse.barnes@intel.com>
In-Reply-To: <200608280925.34326.jesse.barnes@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Monday, August 28, 2006 8:48 am, Arjan van de Ven wrote:
>> 3rd version; only minor changes this time, the sysreq stuff is gone
>> however.
>>
>> I've decided to not use a namespace prefix; these functions are meant
>> to be generic,  and a namespace prefix is not common for such
>> functions, and it would in addition cause a too narrow usage of this
>> infrastructure.
> 
> Almost forgot--what about documentation?  This is an addition to the 
> driver API, so it should probably be described clearly somewhere, 
> probably in Documentation/ somewhere...

how about linuxdoc??
