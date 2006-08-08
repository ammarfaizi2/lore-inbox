Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbWHHPRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbWHHPRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWHHPRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:17:33 -0400
Received: from mga05.intel.com ([192.55.52.89]:25930 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S964946AbWHHPRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:17:32 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.07,222,1151910000"; 
   d="scan'208"; a="113422443:sNHT948924158"
Message-ID: <44D8AB08.3000006@linux.intel.com>
Date: Tue, 08 Aug 2006 08:17:28 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev <netdev@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2: bad e1000 device name
References: <44D78A48.7050707@goop.org> <20060808004011.ab3cd65f.akpm@osdl.org> <44D8484E.9050904@goop.org>
In-Reply-To: <44D8484E.9050904@goop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> Andrew Morton wrote:
>> e1000 seems OK here.  Don't know, sorry.
>>   
> 
> It's happening to all my ethernet-like devices: the Atheros wireless 
> comes up as a mess too.  It's different each time, so it looks like 
> random uninitialized crud.
> 

is this the binary atheros driver? then please try without that..
