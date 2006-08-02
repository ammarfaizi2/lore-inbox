Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWHBSbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWHBSbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 14:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWHBSbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 14:31:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:23583 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932135AbWHBSbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 14:31:52 -0400
X-IronPort-AV: i="4.07,206,1151910000"; 
   d="scan'208"; a="100954584:sNHT16775101"
Message-ID: <44D0EF56.9020905@intel.com>
Date: Wed, 02 Aug 2006 11:30:46 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Charlie Brady <charlieb@budge.apana.org.au>
CC: Auke Kok <auke-jan.h.kok@intel.com>, NetDev <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       molle.bestefich@gmail.com
Subject: Re: [bug] e100: checksum mismatch on 82551ER rev10
References: <Pine.LNX.4.61.0607311653360.24450@e-smith.charlieb.ott.istop.com> <44D0D7CA.2060001@intel.com> <Pine.LNX.4.61.0608021338490.809@e-smith.charlieb.ott.istop.com>
In-Reply-To: <Pine.LNX.4.61.0608021338490.809@e-smith.charlieb.ott.istop.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2006 18:31:51.0549 (UTC) FILETIME=[EC148AD0:01C6B661]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charlie Brady wrote:
>>> Let's assume that these things are all true, and the NIC currently 
>>> does not work perfectly, just imperfectly, but acceptably. With the 
>>> recent driver change, it now does not work at all. That's surely a 
>>> bug in the driver.
>>
>> There is no logic in that sentence at all. You're saying that the 
>> driver is broken because it doesn't fix an error in the EEPROM?
> 
> I am not asking the driver to fix errors in the EEPROM. I'm asking it to 
> send and receive packets, as it has done in the past.

maybe you are confusing e100 with eepro100. e100 has done this since it made 
it into 2.6.4 or so.

Auke
