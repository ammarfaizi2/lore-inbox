Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311871AbSDDXLR>; Thu, 4 Apr 2002 18:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSDDXK6>; Thu, 4 Apr 2002 18:10:58 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:41208
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311871AbSDDXKg>; Thu, 4 Apr 2002 18:10:36 -0500
Date: Thu, 4 Apr 2002 15:12:37 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre5-ac1
Message-ID: <20020404231237.GH961@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200204041640.g34GeVn13624@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- 2.4.19-pre4-ac4.log	Thu Apr  4 15:09:03 2002
+++ 2.4.19-pre5-ac1.log	Thu Apr  4 15:09:16 2002
@@ -0,0 +1,3 @@
+Linux 2.4.19pre5-ac1
+o	Merge with 2.4.19pre5
+
@@ -10 +13 @@
-+	Fix escaped MWAVE configuration			(Thomas Hood)
+*	Fix escaped MWAVE configuration			(Thomas Hood)
@@ -27 +30 @@
-o	USB serial oops fixes				(Greg Kroah Hartmann)
++	USB serial oops fixes				(Greg Kroah Hartmann)
@@ -30,2 +33,2 @@
-o	Fix a wdt285 EFAULT return, remove crud		(Ron Gage, me)
-o	Fix ioctl return errors on several sound cards	(Ron Gage)
++	Fix a wdt285 EFAULT return, remove crud		(Ron Gage, me)
++	Fix ioctl return errors on several sound cards	(Ron Gage)
@@ -36 +39 @@
-+	Fix panic when writing 0 length ucode chunk	(Tigran Aivazian)
+*	Fix panic when writing 0 length ucode chunk	(Tigran Aivazian)
@@ -40,2 +43,2 @@
-o	TCP correctness fix				(Dave Miller)
-o	Correct mwi acronym in docs			(Geert Uytterhoeven)
+*	TCP correctness fix				(Dave Miller)
++	Correct mwi acronym in docs			(Geert Uytterhoeven)
@@ -43 +46 @@
-o	Fix open/close races in indydog			(Dave Hansen)
++	Fix open/close races in indydog			(Dave Hansen)
@@ -50,14 +53,14 @@
-+	USB support for palm m130			(Udo Eisenbarth)
-+	USB fix for pegasus hotplug crash		(Petko Manolov)
-+ 	USB request sense help for some scanners	(Oliver ?)
-+	USB support for Optus@home 			(Oliver ?)
-+	USB printer updates			(David Paschal, Pete Zaitcev)
-+	Work around USB ATEN keyboard switches		(Vojtech Pavlik)
-+	PWC usb camera updates				("Nemosoft")
-+	Small updates to the USB hub code		(Itai Nahshon)
-+	Fix spinlock handling bugs in ipaq USB		(Ganesh Varadarajan)
-+	OHCI fixes					(David Brownell)
-+	USB docs update					(David Brownell)
-+	UHCI fixes					(Johannes Erdfelt)
-+	Quieten a USB message to debug			(Greg Kroah-Hartmann)
-+	USB bandwidth reporting				(David Brownell)
+*	USB support for palm m130			(Udo Eisenbarth)
+*	USB fix for pegasus hotplug crash		(Petko Manolov)
+* 	USB request sense help for some scanners	(Oliver ?)
+*	USB support for Optus@home 			(Oliver ?)
+*	USB printer updates			(David Paschal, Pete Zaitcev)
+*	Work around USB ATEN keyboard switches		(Vojtech Pavlik)
+*	PWC usb camera updates				("Nemosoft")
+*	Small updates to the USB hub code		(Itai Nahshon)
+*	Fix spinlock handling bugs in ipaq USB		(Ganesh Varadarajan)
+*	OHCI fixes					(David Brownell)
+*	USB docs update					(David Brownell)
+*	UHCI fixes					(Johannes Erdfelt)
+*	Quieten a USB message to debug			(Greg Kroah-Hartmann)
+*	USB bandwidth reporting				(David Brownell)
@@ -66 +69 @@
-+	Adapt HP100 driver to pci api			(Jeff Garzik)
+*	Adapt HP100 driver to pci api			(Jeff Garzik)
@@ -68,2 +71,2 @@
-+	DE620 region handling fixes			(K Kasprzak)
-+	DLink DL2K gige updates			(Edward Peng, Jeff Garzik)
+*	DE620 region handling fixes			(K Kasprzak)
+*	DLink DL2K gige updates			(Edward Peng, Jeff Garzik)
@@ -76,4 +79,4 @@
-+	Merge gcc3 warning fixes for copy/csum		(Jeff Garzik)
-+	Fix bmac build					(Joshua Uziel)
-+	DE4x5 slight tidy up				(Jeff Garzik)
-+	More AC97 ident strings				(Peter Christy)
+*	Merge gcc3 warning fixes for copy/csum		(Jeff Garzik)
+*	Fix bmac build					(Joshua Uziel)
+*	DE4x5 slight tidy up				(Jeff Garzik)
+*	More AC97 ident strings				(Peter Christy)
@@ -88 +91 @@
-+	Add devexit_p() to the wdt_pci watchdog		(Adrian Bunk)
+*	Add devexit_p() to the wdt_pci watchdog		(Adrian Bunk)
@@ -130,2 +133,2 @@
-+	Fix wafer5823 watchdog merge error I made	(Justin Cormack)
-o	Fix Config rule for phonejack pcmcia card	(Eyal Lebedinsky)
+*	Fix wafer5823 watchdog merge error I made	(Justin Cormack)
+*	Fix Config rule for phonejack pcmcia card	(Eyal Lebedinsky)
@@ -133,3 +136,3 @@
-o	Update defconfig/experimental bits		(Neils Jensen)
-o	The incredible shrinking kernel patch		(Andrew Morton)
-o	Clean up BUG() implementation			(Andrew Morton)
+*	Update defconfig/experimental bits		(Neils Jensen)
+*	The incredible shrinking kernel patch		(Andrew Morton)
+*	Clean up BUG() implementation			(Andrew Morton)
@@ -143 +146 @@
-+	Clean up wdt_pci				(Zwane Mwaikambo)
+*	Clean up wdt_pci				(Zwane Mwaikambo)
@@ -152 +155 @@
-+	AT1700 filter fix				(Sawa)
+*	AT1700 filter fix				(Sawa)
@@ -159,3 +162,3 @@
-+	Reparent khubd to init				(Andrew Morton)
-o	EEpro100 test updates				(Arjan van de Ven)
-+	Use named initializers in hwc_con		(Pete Zaitcev)
+*	Reparent khubd to init				(Andrew Morton)
+*	EEpro100 test updates				(Arjan van de Ven)
+*	Use named initializers in hwc_con		(Pete Zaitcev)
@@ -165 +168 @@
-+	Water WDT watchdog driver			(Justin Cormack)
+*	Water WDT watchdog driver			(Justin Cormack)
@@ -167 +170 @@
-+	ITE8330G PIRQ map support			(Tobias Diedrich)
+*	ITE8330G PIRQ map support			(Tobias Diedrich)
@@ -173 +176 @@
-+	ALi M1701 watchdog driver			(Stve Hill)
+*	ALi M1701 watchdog driver			(Stve Hill)
@@ -177 +180 @@
-+	Add mk712 touchscreen driver			(Daniel Quinlan)
+*	Add mk712 touchscreen driver			(Daniel Quinlan)
@@ -184 +187 @@
-o	Next SIS ide update				(Lionel Bouton)
+*	Next SIS ide update				(Lionel Bouton)
@@ -206 +209 @@
-+	Fix printk message levels in pci code		(Denis Vlasenko)
+*	Fix printk message levels in pci code		(Denis Vlasenko)
@@ -213 +216 @@
-+	Initial Ricoh ZVbus support			(Marcus Metzler)
+*	Initial Ricoh ZVbus support			(Marcus Metzler)
@@ -220,2 +223,2 @@
-+	Update reisefsprogs version			(Paul Komkoff)
-+	RME Hammerfall driver update			(Günter Geiger)
+*	Update reisefsprogs version			(Paul Komkoff)
+*	RME Hammerfall driver update			(Günter Geiger)
@@ -225 +228 @@
-+	Add help text to patch-kernel script		(Damjan Lango)
+*	Add help text to patch-kernel script		(Damjan Lango)
@@ -228,4 +231,4 @@
-+	Add WD xd signature to 2.4 (from 2.2)		(Jim Freeman)
-+	Update sc1200 watchdog				(Zwane Mwaikambo)
-+	Switch wdt501 watchdog driver to bitops		(me)
-+	Much updated LSI logic MPT fusion drivers	(Pam Delaney)
+*	Add WD xd signature to 2.4 (from 2.2)		(Jim Freeman)
+*	Update sc1200 watchdog				(Zwane Mwaikambo)
+*	Switch wdt501 watchdog driver to bitops		(me)
+*	Much updated LSI logic MPT fusion drivers	(Pam Delaney)
@@ -237 +240 @@
-+	Fix w83877 SMP deadlock, clean up locking	(me)
+*	Fix w83877 SMP deadlock, clean up locking	(me)
@@ -286 +289 @@
-+	Add missing cpu_relax to iph5526 driver		(me)
+*	Add missing cpu_relax to iph5526 driver		(me)
@@ -548 +551 @@
-o	Add bridge resources to the resource tree	(Ivan Kokshaysky)
++	Add bridge resources to the resource tree	(Ivan Kokshaysky)
