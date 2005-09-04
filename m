Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbVIDTL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbVIDTL0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 15:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbVIDTL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 15:11:26 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:22939 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S1751028AbVIDTLZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 15:11:25 -0400
Message-ID: <431B46DB.9070705@free.fr>
Date: Sun, 04 Sep 2005 21:11:23 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Giampaolo Tomassoni <g.tomassoni@libero.it>
CC: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org,
       linux-atm-general@lists.sourceforge.net
Subject: Re: R: R: [Linux-ATM-General] [ATMSAR] Request for review - update
 #1
References: <NBBBIHMOBLOHKCGIMJMDIEIIEKAA.g.tomassoni@libero.it>
In-Reply-To: <NBBBIHMOBLOHKCGIMJMDIEIIEKAA.g.tomassoni@libero.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giampaolo Tomassoni wrote:
>>-----Messaggio originale-----
>>Da: Francois Romieu [mailto:romieu@fr.zoreil.com]
>>Inviato: domenica 4 settembre 2005 17.33
>>A: Giampaolo Tomassoni
>>Cc: linux-kernel@vger.kernel.org;
>>linux-atm-general@lists.sourceforge.net
>>Oggetto: Re: R: [Linux-ATM-General] [ATMSAR] Request for review - update #1
>>
>>...omissis...
>>
>>I'd be happily surprized to see more documented ADSL PCI/USB device in the
>>near future. :o(
> 
> 
> OT Question. What about an open adsl device? The linux community had been bumped out by the adsl market for at least a couple of years, and nobody knows (or tells) why...
> 
> That could be a definitive answer. Is there anybody interested in this?
> 
> 
The problem is that lot's of new devices implement part of their dsp 
function in the kernel space instead of in the device.
And as company don't want to publish their dsp algorith and open source 
it, we can't have open source driver for it.

That the case for bewan device (that even include a libm in their 
source) and for pulsar pci device...
