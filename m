Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266198AbRGAXGj>; Sun, 1 Jul 2001 19:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266080AbRGAXG3>; Sun, 1 Jul 2001 19:06:29 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:33289 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266264AbRGAXGR>; Sun, 1 Jul 2001 19:06:17 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter.Nuetzel@t-online.de (Dieter =?iso-8859-1?q?N=FCtzel?=)
Organization: DN
To: George Garvey <tmwg-linuxknl@inxservices.com>
Subject: Re: ASUS A7V/Thunderbird 1GHz lockup problems observation w/fix for me
Date: Sun, 1 Jul 2001 23:09:23 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <15GqHw-0EziM4C@fwd06.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Ever since building this system there have been spontaneous and
> unpredictable lockups, usually at least once per day. Sometimes several per
> day. The lockup is sometimes preceded by X starting to display things
> strangely (on a Voodoo 3 w/XF 4.X). Then I have a few minutes to reboot
> before it hangs (can't log in using ssh from another system.)
>    With the Northbridge discussion, I couldn't pinpoint anything to fix it,
> so I started experimenting.
>    Things got better by upgrading the BIOS; but still many hangs.
>    I've discovered that changing the CPU voltage from the default to 1.75V
> results in a stable system. Higher than that doesn't work. Lower still gets
> lockups.
>    It doesn't look like everyone has this problem with similar setups. But
> if there are others, I wanted to share this discovery.

How good is your power supply?
Only to be sure. You know about AMD's recommendations for a proper power 
supply if you are building an AMD Athlon/Duron system.
Things going better with Athlon (MP) 4 and mobile Duron.
The dual Athlon MP systems are another story...
...but smooth performer (I love it).

MSI has a very good summary on there German website.
I've piped it through Babel and sounds a bit funny, but anyway:-)

[-]
 Ref NR: 09-0001 
 05.04.2001 

 Question/symptom: 
 The operating system cannot be installed with my new MSI Main board. 

 A cause: 
 High requirements of electric current of new PCUs, diagram cards, large 
memory modules and some PCI cards (e.g. TV cards) provide for it that the 
usual 250 Watts of power packs the necessary performance any longer do not 
apply. 

 Response/solution: 
 MSI recommends to use a sufficiently dimmensioniertes power pack with 
following minimum values.
 +3.3 V - 20 ampere
 +5.0 V - 30 ampere
 Power packs with these values have usually a total output of ca.350 Watt. 
Please you consider however it by this also power packs give those the 
specification given above do not fulfill (server power packs) and therefore 
are unsuitable. 


 Ref NR: 09-0003 
 11.04.2001 

 Question/symptom: 
 Why does my Athlon Main board have so high requirements of electric current? 

 Response/solution: 
 Measurements or specification in the AMD data sheets resulted in, measured 
the following current loads on the particularly critical 3.3V-Leitung during 
a time demo 1 (Crusher) of Quake 3 on a MS-6167 or a MS-6195 K7T pro:
 
 Component:			Maximum stream on 3.3V 
 AMD Athlon (all clock frequencies)	9,6 A 
 Main board + 3 DIMM of modules	2,0 A 
 NVIDIA Geforce 256		8,6 A 
 Total:				20,2 A 
[-]

I am, like Alan Cox (:-) on the Athlon track since August '99 and my local 
dealer where I do Linux consulting sells over 95% AMD CPUs since then...

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de

