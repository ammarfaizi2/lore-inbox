Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTL2QS3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTL2QS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:18:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:8688 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263523AbTL2QS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:18:27 -0500
Date: Mon, 29 Dec 2003 10:18:19 -0600
Subject: Re: [OT] working mini-pci wlan cards in thinkpads
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: lkml <linux-kernel@vger.kernel.org>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>, Disconnect <lkml@sigkill.net>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0312161506130.6253-100000@twin.uoregon.edu>
Message-Id: <9D779E6A-3A1A-11D8-A21C-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.553)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, Dec 16, 2003, at 17:10 US/Central, Joel Jaeggli wrote:
> On Monday, Dec 15, 2003, at 18:03 US/Central, Disconnect wrote:
>>
>> And yet I was able to call dell and just order an older card to go in
>> my Inspiron.  (A standard 802.11b card; orinoco on a pci->cardbus 
>> bridge.)
>> The only regulatory info they mentioned was including a pack of the
>> certified-by stickers to replace the ones that were on the laptop from
>> the original card.
>
> the truemobile 1150 is just an off the shelf avaya/agere/orinoco/proxim
> minipci card... I happen to have one with an acer label in my inspiron
> 4150 but since they all have the same fcc id they were all made by 
> agere.

Thanks for the recommendation! I installed a Dell Truemobile 1150 in a 
(gift) Thinkpad R40 last week. Worked perfectly in WinXP and Knoppix 
3.3, no fussing with (PrismII) drivers in either case.

Also, the antenna leads were plenty long enough, and I didn't see any 
BIOS authorization problems (as mentioned at 
http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/0147.html).

-- 
Hollis Blanchard
IBM Linux Technology Center

