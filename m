Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131577AbRBLWIe>; Mon, 12 Feb 2001 17:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131450AbRBLWIY>; Mon, 12 Feb 2001 17:08:24 -0500
Received: from mailman.techspan.com ([4.21.76.5]:64004 "EHLO
	mailman.techspan.com") by vger.kernel.org with ESMTP
	id <S130736AbRBLWIH>; Mon, 12 Feb 2001 17:08:07 -0500
Message-ID: <3A885EC5.7080706@techspan.com>
Date: Mon, 12 Feb 2001 17:08:05 -0500
From: Mark Swanson <Mark.Swanson@techspan.com>
Organization: Techspan
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.14-win4lin i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PS/2 Mouse/Keyboard conflict and lockup
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >I'm also seeing a ps/2 mouse bug, with 2.4.0-pre5 (I think) on a 
 >CS433 (486/33 laptop) 
 >Freezes after some time in X, killing keyboard.
 >Is there a generic approach to finding where this sort of problem lies?

The exact same thing happens to me too. Winbook XL2 laptop.
I can ssh to the box and kill X, and then I can use the keyboard/PS2 
mouse again!

The same thing happens in console mode. Keyboard/mouse lock up, I ssh, 
do the reverse of above (startx) and I can use my mouse and keyboard again!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
