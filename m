Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbUKOUr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUKOUr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUKOUqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:46:15 -0500
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:51654 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S261693AbUKOUpr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:45:47 -0500
Message-ID: <41991511.1080006@ttnet.net.tr>
Date: Mon, 15 Nov 2004 22:44:01 +0200
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@redhat.com>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [netdrvr] netdev-2.4 queue updated
References: <4198C64A.6050900@ttnet.net.tr> <4198E20E.5070305@pobox.com> <20041115173245.GI14381@redhat.com>
In-Reply-To: <20041115173245.GI14381@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville wrote:
> On Mon, Nov 15, 2004 at 12:06:22PM -0500, Jeff Garzik wrote:
> 
>>O.Sezer wrote:
>>
>>>>John W. Linville:
>>>> o 3c59x: resync with 2.6
>>>>
>>>
>>>Any specific reason that the following two are not included ?
>>>
>>>3c59x: reload EEPROM values at rmmod for needy cards:
>>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109726032213947&w=2
>>>
>>>3c59x: remove EEPROM_RESET for 3c905 :
>>>http://marc.theaimsgroup.com/?l=linux-kernel&m=109802672909516&w=2
>>
>>Ask John Linville...  IIRC they caused problems?
> 

I have two machines with 3c905's (Boomerang series) running with
Linville's 3 patches without any problems for more than 10 days I
think. But that's only me.

> Actually, the second one was there to correct the first one.
> (Only PART of the first patch was undone by the second one.)

I'm aware of that, thanks.

> They are additive, so they should be applied in the order above.
> If you'd prefer, I could gen-up a single patch?
> 
> Thanks,
> 
> John

Ozkan Sezer

