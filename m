Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311848AbSCTRJy>; Wed, 20 Mar 2002 12:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311844AbSCTRJe>; Wed, 20 Mar 2002 12:09:34 -0500
Received: from 208-59-250-172.c3-0.smr-ubr1.sbo-smr.ma.cable.rcn.com ([208.59.250.172]:51072
	"EHLO bradm.net") by vger.kernel.org with ESMTP id <S311843AbSCTRJW>;
	Wed, 20 Mar 2002 12:09:22 -0500
Date: Wed, 20 Mar 2002 12:08:39 -0500
From: Bradley McLean <brad@bradm.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bradley McLean <bradlist@bradm.net>, linux-kernel@vger.kernel.org
Subject: Re: Hard hang on 3Ware7850, Dual AthlonMP, Tyan2462
Message-ID: <20020320120839.A7530@nia.bradm.net>
In-Reply-To: <20020320111840.A7078@nia.bradm.net> <E16njGB-0002ku-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) [020320 11:34]:
> 
> Ok thats the fourth report of this 3ware + 2462 SMP only breakage
> 
> > Anyone with suggestions, or test cases?
> 
> Apparently if you swap the Tyan for something like the ASUS dual athlon
> board it works. Dunno if its hardware, bios or software.

Thanks, Alan.  Anybody out there with the ASUS dual board who can send
me your bootlog (I'm primarily interested in the processor and APIC init
sections, digging for clues by comparing).

-Brad

