Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272579AbRILUH0>; Wed, 12 Sep 2001 16:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272582AbRILUHG>; Wed, 12 Sep 2001 16:07:06 -0400
Received: from cs173101.pp.htv.fi ([213.243.173.101]:9898 "EHLO
	porkkala.cs173101.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S272579AbRILUGy>; Wed, 12 Sep 2001 16:06:54 -0400
Message-ID: <3B9FC05F.D35040C8@pp.htv.fi>
Date: Wed, 12 Sep 2001 23:06:55 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Marco Colombo <marco@esi.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA chipset
In-Reply-To: <Pine.LNX.4.33.0109122010120.8745-100000@Megathlon.ESI>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Colombo wrote:
> 
> Sorry to bother you again with this issue, Alan... by 'AMD chipsets'
> you mean BOTH north and south bridges (eg. 761 + 766) or does it include
> also AMD NB + VIA SB combo?
> AMD 761 + VIA 686B based MBs are quite common this days: are they "safe"
> (do you have failure reports)?

At least my ASUS A7M266 works very well. It has AMD 761 nb and VIA 686B sb
and the 686B is used only for IDE and IO interfaces. PCI bus comes from the
761, AFAIK.

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
