Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWBNIGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWBNIGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWBNIGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:06:30 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:61867 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932256AbWBNIG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:06:29 -0500
Date: Tue, 14 Feb 2006 09:06:08 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       alex@samad.com.au
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43F098A2.nailKUSL1W9PE@burner>
Message-ID: <Pine.LNX.4.61.0602140905490.7198@yvahk01.tjqt.qr>
References: <43EA1D26.nail40E11SL53@burner> <20060208165330.GB17534@voodoo>
 <43EB0DEB.nail52A1LVGUO@burner> <Pine.LNX.4.61.0602091729560.30108@yvahk01.tjqt.qr>
 <43EB7210.nailIDH2JUBZE@burner> <Pine.LNX.4.61.0602091813260.30108@yvahk01.tjqt.qr>
 <43EB7BBA.nailIFG412CGY@burner> <mj+md-20060209.173519.1949.atrey@ucw.cz>
 <43EC71FB.nailISD31LRCB@burner> <20060210114930.GC2750@DervishD>
 <20060213005002.GK26235@samad.com.au> <43F098A2.nailKUSL1W9PE@burner>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >     My system is clueless, too! If I write a CD before plugging my
>> > USB storage device, my CD writer is on 0,0,0. If I plug my USB
>> > storage device *before* doing any access, my cdwriter is on 1,0,0.
>> > Pretty stable.
>>
>> Had exactly the same problem with firewire and usb devices, depending on
>> the order of the loading of the kernel modules it all changes!
>
>This is a deficite of the Linux kernel model. You don't have similar
>problems on Solaris.
>
Hm, did not you just outline that on Solaris, new devices always get a new 
ID?


Jan Engelhardt
-- 
