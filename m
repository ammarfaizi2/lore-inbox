Return-Path: <linux-kernel-owner+w=401wt.eu-S1030284AbXAECsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbXAECsn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 21:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbXAECsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 21:48:43 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:40328 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030284AbXAECsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 21:48:42 -0500
Date: Thu, 04 Jan 2007 21:48:36 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: wireless Q
In-reply-to: <20070104221418.GA5684@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: "John W. Linville" <linville@tuxdriver.com>
Message-id: <200701042148.36521.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200701040051.51930.gene.heskett@verizon.net>
 <20070104221418.GA5684@tuxdriver.com>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 January 2007 17:14, John W. Linville wrote:
>On Thu, Jan 04, 2007 at 12:51:49AM -0500, Gene Heskett wrote:
>> I bought a Belkin Wireless G card, a pci 802-11 radio of some sort.
>>
>> The main chip on it wears the label "RTL8185L"
>>
>> Is there any support for making this a wireless server in the kernel
>> at the present time?
>>
>> I have visions of sticking it in the last pci slot of a box running
>> DD-WRT if there is a driver available.
>
>Gene,
>
>There is no such driver in the kernel at this time.  There is an
>out-of-kernel driver available here:
>
>	http://rtl8180-sa2400.sourceforge.net/
>
>YMMV.
>
>FWIW, I know of at least one person working on a driver for the
>d80211-based stack in wireless-dev.  I'm not sure when that will be
>available publicly.
>
>Hth!
>
Possibly in the future John.  I took the Belkin back and got a Netgear 
WG311T for another $35.  Staples let me open it there and based on the 
fact that the cd has some drivers on it that start with ATHE_* (the 
chipset has a tincover soldered to the board over it so we can't ID it 
that way), I'm assuming its an Atheros chipset, and Brian does has that 
support available in DD-WRT, which is where this puppy will live.  But 
I'm up to my butt in alligators ATM, so it may be a day or 3 till I can 
try it.  I have a 160GB drive laying on the lappies carry case in the 
doorway, to go up and be installed in the neighbors box to replace a 30GB 
that upchucked all over their windows install, and convince it to let me 
install windows on that box the 2nd time.  M$ are such rectums over that.  
Its piracy you know. :(

And its already 21:22 here and I'd druther space it for the night. :(  I 
probably will since I kept them up till midnight last night finding the 
missing 1.5 megabaud download speed and making their wireless in a new 
Acer lappy work.  But its unsecured and that makes me nervous if some war 
driver comes by.  Not a high probability out here in the sticks, but you 
never know.  So I gotta go ask some dumb questions here and there.

Thanks John.

>John

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2007 by Maurice Eugene Heskett, all rights reserved.
