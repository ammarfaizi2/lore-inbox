Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272598AbRIFU4H>; Thu, 6 Sep 2001 16:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272594AbRIFUz5>; Thu, 6 Sep 2001 16:55:57 -0400
Received: from femail33.sdc1.sfba.home.com ([24.254.60.23]:35518 "EHLO
	femail33.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272598AbRIFUzp>; Thu, 6 Sep 2001 16:55:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: linux-kernel@vger.kernel.org
Subject: K7/Athlon optimizations again. (The sacrifices worked??) (VIA KT133A chipset)
Date: Thu, 6 Sep 2001 13:55:31 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01090613553103.00465@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Charles Cazabon, I now have a new theory.
to quote, I'm the one he quoted here:

----Begin Quote---
> And I CAN nail it down to a particular chipset. It only occurs on VIA 
> KT133A chipsets so far, unfortunitely it doesn't occur 100% of the time 
> on that chipset.


I'd be curious if it's an issue with only one brand or release of BIOS
then.
----End Quote----

And thus begins a new round, I started by slapping myself.

I've seen two instances so far of someone mentioning that one BIOS 
release caused problems while another did not. One was mentioned on the 
list, one was part of the reports sent to me. I completely passed over 
this information and I have no idea why.

Everyone having problems, here's what you could try:
Upgrade to the latest BIOS version for your board.
If you are at the latest BIOS version, go back a version or two.

For those NOT having problems, and who would like to help test/live 
dangerously, could you also try the previously mentioned upgrades or 
downgrades? 

And be sure to have a non-K7 optimized kernel installed as a backup 
incase you forget to make TWO diskettes for upgrading your BIOS and it's 
your only system :)

This problem doesn't even affect me, I'm not a developer, and any system 
I buy in the future will be long after the KT133A is "outdated", I don't 
know why I'm hammering at this so much.
