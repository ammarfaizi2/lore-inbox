Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130831AbRBEQcD>; Mon, 5 Feb 2001 11:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130869AbRBEQbx>; Mon, 5 Feb 2001 11:31:53 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:37390 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S130831AbRBEQbj>;
	Mon, 5 Feb 2001 11:31:39 -0500
Date: Mon, 05 Feb 2001 17:31:27 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: RE: IDE timeouts 2.4.1
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A7ED55F.C42CBF53@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    From: Andre Hedrick (andre@linux-ide.org)
>    Date: Fri Feb 02 2001 - 23:50:42 EST
>      
>    Do not trust the second channel to ATA devices.
>    Only ATAPI can live there.
>    I watch it all day long eat my second drives.

Is this only for this particular chipset or general ATA issue (hope not) ?

>    The OSB4 is not a pretty thing to play with, and I will have the chance to
>    fix the CSB5 before it goes final.
>      
>    Cheers,
>        
>    On Fri, 2 Feb 2001, Dunlap, Randy wrote:
>      
>    > I'm also getting a ton of these, along with lots of 
>    > file corruption. I could handle the timeouts and 
>    > rebooting every once in awhile if I didn't also have 
>    > the corruption. 
>    > 
>    > Do I have some incorrect IDE parameters? 
>    >       
>    > (using 2.4.0, not 2.4.1) 
>    > dual Pentium III 933 MHz (STL2 board) 
>    > SAMSUNG 20 GB IDE hard drive 
>    > ServerWorks chipset   
>    > 
>    > details---------------------------------- 

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
