Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135503AbRAGBpt>; Sat, 6 Jan 2001 20:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135520AbRAGBpk>; Sat, 6 Jan 2001 20:45:40 -0500
Received: from antiochus-fe0.ultra.net ([146.115.8.188]:24591 "EHLO
	antiochus-fe0.ultra.net") by vger.kernel.org with ESMTP
	id <S135503AbRAGBpg>; Sat, 6 Jan 2001 20:45:36 -0500
Message-ID: <3A57CAE8.9050404@maniac.ultranet.com>
Date: Sat, 06 Jan 2001 20:48:24 -0500
From: "David C. Davies" <davies@maniac.ultranet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Andi Kleen <ak@suse.de>, Bill Wendling <wendling@ganymede.isdn.uiuc.edu>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <20001103202911.A2979@gruyere.muc.suse.de> <200011031937.WAA10753@ms2.inr.ac.ru> <20001103160108.D16644@ganymede.isdn.uiuc.edu> <3A033C82.114016A0@mandrakesoft.com> <20001104004129.C5173@gruyere.muc.suse.de> <3A0350EC.8B1A3B4D@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

As you can see, I get little time to attend to maintenance chores on the 
de4x5 driver. If there are particular problems that you want sorted out 
please let me know and I'll see what I can do.

Regards,

Dave

------------------------------------------------------

Jeff Garzik wrote:

> Andi Kleen wrote:
> 
>> de4x5 is stable, but tends to perform badly under load, mostly because
>> it doesn't use rx_copybreak and overflows standard socket buffers with its
>> always MTU sized skbuffs.
> 
> 
> One of the reasons that de4x5 isn't gone already is that I get reports
> that de4x5 performs better than the tulip driver for their card.
> 
> 	Jeff
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
