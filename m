Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTJTNqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 09:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTJTNqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 09:46:20 -0400
Received: from www02.ies.inet6.fr ([62.210.153.202]:53647 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S261820AbTJTNqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 09:46:18 -0400
Message-ID: <3F93E728.5050908@inet6.fr>
Date: Mon, 20 Oct 2003 15:46:16 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: konsti@ludenkalle.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: Uncorrectable Error on IDE, significant accumulation
References: <20031020132705.GA1171@synertronixx3>
In-Reply-To: <20031020132705.GA1171@synertronixx3>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Kletschke wrote the following on 10/20/2003 03:27 PM :

>Hi there.
>
>I have a probably unusual question which is mainly directed to the
>linux-kernel IDE driver developers due to their experience with IDE
>disks.
>
>I have a PC @home, which accumulates HDDs in it which die.
>
>This Weekend my 120GB Maxtor begun to die with Uncorrectable Errors.
>I thought "OK, another damn Quality Hard Drive" But half a year ago I
>replaced a not so old 40GB MAxtor in it and before that a 20GB System
>Disk and a WD800JB has already 6 Secors remapped (smartctl -a). My
>friends call me the "Master of the HDD cemetary".
>
>After that I realized, that 99% of my harddisk which die do this in that
>PC. I have a K7S5A Mainboard in it with SiS chipset. Kernel IDE Driver
>sis5513 is compiled in, UDMA switched on.
>  
>


When did you purchase it ? Better : can you find the revision (black on 
white sticker glued in the corner of the motherboard near the last PCI 
slot) ?

There were electrical defects with the earliest K7S5A revisions (I 
returned one myself). Rev 0, 1, 2 and 3 are affected, I don't remember 
for 4-6 but IIRC rev 7 and above aren't affected : I have a rev 5 or 7 
at home (don't remember which one it is) and it works perfectly.

LB.

