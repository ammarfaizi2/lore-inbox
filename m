Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318485AbSGSK2O>; Fri, 19 Jul 2002 06:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318487AbSGSK2N>; Fri, 19 Jul 2002 06:28:13 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:41405 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S318485AbSGSK2N>;
	Fri, 19 Jul 2002 06:28:13 -0400
Date: Fri, 19 Jul 2002 12:31:07 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207191031.MAA26909@harpo.it.uu.se>
To: dave@cs.curtin.edu.au, zwane@linuxpower.ca
Subject: Re: SMP Problem with 2.4.19-rc2 on Asus A7M266-D
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2002 10:31:18 +0200 (SAST), Zwane Mwaikambo wrote:
>On Fri, 19 Jul 2002, David Shirley wrote:
>
>> bit further then it hangs and prints out "APIC error on CPU0: 00(08)"
>
>That looks really odd, thats actually a reserved bit. I'll try dig a 
>little further.

08 is a "Receive Accept Error" for all but the P4 family.
The K7s tend to be like the P6s.

/Mikael
