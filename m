Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265588AbUBBDOq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 22:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265590AbUBBDOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 22:14:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:7811 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265588AbUBBDOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 22:14:44 -0500
Message-ID: <401DC09B.4060001@redhat.com>
Date: Sun, 01 Feb 2004 17:14:35 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031225 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lai Zit Seng <lzs@comp.nus.edu.sg>
CC: linux-kernel@vger.kernel.org
Subject: Re: Trouble with Cisco Airo MPI350 and kernel-2.6.1+
References: <Pine.LNX.4.44.0402021106000.23974-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0402021106000.23974-100000@localhost.localdomain>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lai Zit Seng wrote:
> On Sun, 1 Feb 2004, Warren Togami wrote:
> 
> 
>>Are these many errors normal?
>>
>>[root@ibmlaptop etc]# iwconfig eth1
>>Warning: Driver for device eth1 has been compiled with version 16
>>of Wireless Extension, while this program is using version 15.
>>Some things may be broken...
>>
>>eth1      IEEE 802.11-DS  ESSID:"apophis"  Nickname:"ibmlaptop"
>>           Mode:Managed  Frequency:2.412GHz  Access Point: 00:0C:41:75:D4:02
>>           Bit Rate:11Mb/s   Tx-Power=20 dBm   Sensitivity=0/0
>>           Retry limit:16   RTS thr:off   Fragment thr:off
>>           Encryption key:****-****-**   Security mode:open
>>           Power Management:off
>>           Link Quality:30/0  Signal level:-70 dBm  Noise level:-98 dBm
>>           Rx invalid nwid:59  Rx invalid crypt:0  Rx invalid frag:0
>>           Tx excessive retries:1  Invalid misc:4900   Missed beacon:3
> 
> 
> It seems like if you have bunch of rx invalid nwids... it could be due to 
> interference from another wireless network in the area?
> 
> Regards,
> 
> .lzs

Unlikely, it is extremely clean when I use my orinoco_cs card.

Warren
