Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129901AbRADVIg>; Thu, 4 Jan 2001 16:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130006AbRADVIQ>; Thu, 4 Jan 2001 16:08:16 -0500
Received: from Cantor.suse.de ([194.112.123.193]:39180 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129773AbRADVH4>;
	Thu, 4 Jan 2001 16:07:56 -0500
Date: Thu, 4 Jan 2001 22:05:01 +0100 (CET)
From: egger@suse.de
Reply-To: egger@suse.de
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1010104155136.18796A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <20010104220709.11E3D51E9@Nicole.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  4 Jan, Richard B. Johnson wrote:

> Well they do! It's just not allowed for us (the users) to know that
> they
> __didn't__ run completely out of power!  If the thing is so dead
> that it won't recharge, it still has 'power' (enough to keep static
> RAM alive). Just remove the battery, wait about 120 seconds for a
> capacitor to discharge,  and, zap, no more stored phone numbers.
> Static RAM with an electrolytic capacitor, isolated with a diode,
> takes so little power that you can normally change defective batteries
> if you don't take too long.

 I've several Nokias and Siemens phones here. All of them will survive
 for weeks without any battery connected; and not only the phone numbers
 on the SIM card. I guess they all have FlashRAM, although I haven't 
 disassembled one recently. 

-- 

Servus,
       Daniel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
