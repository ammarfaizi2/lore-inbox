Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313315AbSDOWFG>; Mon, 15 Apr 2002 18:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313316AbSDOWFG>; Mon, 15 Apr 2002 18:05:06 -0400
Received: from dsl092-148-080.wdc1.dsl.speakeasy.net ([66.92.148.80]:22144
	"EHLO tyan.doghouse.com") by vger.kernel.org with ESMTP
	id <S313315AbSDOWFE>; Mon, 15 Apr 2002 18:05:04 -0400
Date: Mon, 15 Apr 2002 18:04:54 -0400 (EDT)
From: Maxwell Spangler <maxwax@mindspring.com>
X-X-Sender: maxwell@tyan.doghouse.com
To: Meelis Roos <mroos@linux.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re:  [COMMENTS IDE 2.5] - "idebus=66" in 2.5.8 results in "ide_setup:
 idebus=66 -- BAD OPTION"
In-Reply-To: <E16xA96-0002Ru-00@roos.tartu-labor>
Message-ID: <Pine.LNX.4.44.0204151804100.1145-100000@tyan.doghouse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2002, Meelis Roos wrote:

> MH> Kernel command line: BOOT_IMAGE=2.5.8-without-TCQ ro root=303 video=matrox:vesa:0x118 idebus=66 profile=2
> MH> ide_setup: idebus=66
> MH> ide: system bus speed 66MHz
> 
> MH> works like a charm :)
> 
> Do you really have an IDE controller that does 66 MHz PCI? What kind on IDE
> controller is this?

I have a Promise Ultra133TX2 card on my shelf that is 32-bit PCI with 66Mhz 
operation.

I don't know to what extent it is supported yet.. Andre?
-- ----------------------------------------------------------------------------
Maxwell Spangler                                                 Save Futurama!
Program Writer                                               Sign the petition!
Greenbelt, Maryland, U.S.A.                         http://www.gotfuturama.com/
Washington D.C. Metropolitan Area 

