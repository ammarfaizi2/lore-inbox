Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbRAASNl>; Mon, 1 Jan 2001 13:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131954AbRAASNa>; Mon, 1 Jan 2001 13:13:30 -0500
Received: from mail.dol.net ([204.183.91.8]:32267 "HELO dol.net")
	by vger.kernel.org with SMTP id <S131508AbRAASNS>;
	Mon, 1 Jan 2001 13:13:18 -0500
Message-ID: <3A50BD68.2030002@dol.net>
Date: Mon, 01 Jan 2001 12:24:56 -0500
From: Robert Baruch <autophile@dol.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10 i686; en-US; m18) Gecko/20001206
X-Accept-Language: en
MIME-Version: 1.0
To: Linux USB Storage List <usb-storage@one-eyed-alien.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Linux USB Storage List <usb-storage@one-eyed-alien.net>
Subject: Re: [usb-storage] Re: [patchlet] enable HP 8200e USB CDRW
In-Reply-To: <Pine.LNX.4.30.0012311255470.29214-100000@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sun, 31 Dec 2000, Matthew Dharm wrote:
> 
> 
>> Um, I'm not sure that this driver is even ready for the EXPERIMENTAL label.
>> What does the driver's author say?

I'd say it's ready for prime-time. So far the problems that have been 
described to me have to do with not being able to burn CD's because of 
too high a write speed. There is still an unresolved problem with 
disk-at-once writing, but nothing that prevents work from being done.

--Rob


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
