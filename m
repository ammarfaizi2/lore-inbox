Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264170AbTICSXf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTICSW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:22:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48329 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264170AbTICSVw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:21:52 -0400
Message-ID: <3F563130.6040609@pobox.com>
Date: Wed, 03 Sep 2003 14:21:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Stuart MacDonald <stuartm@connecttech.com>,
       "'Mariusz Zielinski'" <levi@wp-sa.pl>, root@chaos.analogic.com,
       "'James Clark'" <jimwclark@ntlworld.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Driver Model
References: <004801c37233$08c93b10$294b82ce@stuartm> <1062608313.19058.133.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062608313.19058.133.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2003-09-03 at 16:50, Stuart MacDonald wrote:
> 
>>From: Mariusz Zielinski [mailto:levi@wp-sa.pl] 
>>
>>>Realtek 8180L wlan chipset driver.
>>
>>From:
>>http://www.realtek.com.tw/downloads/downloads1-3.aspx?series=16&Software=True
>>
>>These drivers are all source and appear to be all GPLed.
> 
> 
> Only part source so realtek need a little re-education to make them fix
> the drivers. Someone who deals with realtek drivers (Jeff Garzik ?) care
> to start a polite initial dialog ?


Maybe I'm blind but I don't see 8180 wireless support at all there.

They have for a driver whose zipfile is called "8139cp".  You unpack it 
and it's an ancient 8139too.c with 8139C+ support added :)

But no 8180 support?

	Jeff



