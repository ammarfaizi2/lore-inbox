Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318785AbSHLTgJ>; Mon, 12 Aug 2002 15:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318792AbSHLTgJ>; Mon, 12 Aug 2002 15:36:09 -0400
Received: from feline.chl.chalmers.se ([129.16.214.88]:38925 "EHLO
	feline.chl.chalmers.se") by vger.kernel.org with ESMTP
	id <S318785AbSHLTgI>; Mon, 12 Aug 2002 15:36:08 -0400
Date: Mon, 12 Aug 2002 21:39:54 +0200 (CEST)
From: Fredrik Ohrn <ohrn@chl.chalmers.se>
To: linux-kernel@vger.kernel.org
Subject: Re: sungem 0.97 driver doesn't work with "Sun GigabitEthernet/P 2.0"
 card.
Message-ID: <Pine.LNX.4.44.0208122129030.17687-100000@feline.chl.chalmers.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Aug 2002, David S. Miller wrote:
>
>    From: Fredrik Ohrn <ohrn@chl.chalmers.se>
>    Date: Mon, 12 Aug 2002 15:53:11 +0200 (CEST)
> 
>    gem: SW reset is ghetto.
> 
> If you get this message you won't get a working card at all.
> 
> Most likely the BIOS isn't assigning resources to the card
> correctly. Some x86 guru would need to look at PCI config
> space dumps to figure out what might be going wrong. 
>

OK, I also have an identical card sitting in a Sun Enterprise 450 box.
In case someone can tell me how to do it in Solaris 8 I can check how 
the card is configured there.

BTW, please CC me as I'm not subscribed to the list.


Regards,
Fredrik

-- 
   "It is easy to be blinded to the essential uselessness of computers by
   the sense of accomplishment you get from getting them to work at all."
                                                   - Douglas Adams

Fredrik Öhrn                               Chalmers University of Technology
ohrn@chl.chalmers.se                                                  Sweden


