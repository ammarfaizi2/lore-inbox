Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267693AbTASSYG>; Sun, 19 Jan 2003 13:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267694AbTASSYG>; Sun, 19 Jan 2003 13:24:06 -0500
Received: from virgo.i-cable.com ([203.83.111.75]:22150 "HELO
	virgo.i-cable.com") by vger.kernel.org with SMTP id <S267693AbTASSYF>;
	Sun, 19 Jan 2003 13:24:05 -0500
From: "Sampson Fung" <sampson@attglobal.net>
To: <linux-kernel@vger.kernel.org>
Subject: A Flightening and Strange experience compiling 2.5.58
Date: Mon, 20 Jan 2003 02:32:44 +0800
Message-ID: <000001c2bfe9$28bf8340$febca8c0@noelpc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2 days a ago, I am compiling 2.5.58 to test Intel810fb.

After serveal compiles , my machine stop responding with a repeating
message shows up in console:

<iDDDDD> setting is too high, resetting... (where D is a digit)

(I did not record the details, so please don't blame me not providing
details, just want to share my experience).

At this point, my machine is total not responding, ping from other
machine failed, console keyboard not responding, etc.

But the error mesage is repeating.

Then I press reset button.  

After reset, my box ask me to insert a boot disk in Drive A.  (I do not
see any POST occuring, no memory counting, etc).

After pressing a few <return>s, I unplug the power and turn on the
machine again.

Same problem.  After a few retries (unplug power and power on again), my
heart is fearing my mainboard's BIOS is damaged.
(I have a similar experience after flash a BIOS and result to a useless
mainboard.)

Then I unplug my machine and going  somewhere.

After about 2 hours, I power on the machine again.

This time, after POST, BIOS reports CMOS data checksum failed.  And
allow me to into BIOS setup to config again.

After that, my machine is working normally again.

And I have totally no hints to what happened.

Does anyone has similar problems?  That is:  H/W POST do not start after
machine hangs.

Sorry for not able to provide more details again.

Sampson Fung
A New Comer to Kernel Testing.


