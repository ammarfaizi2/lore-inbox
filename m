Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290967AbSBGAGM>; Wed, 6 Feb 2002 19:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290969AbSBGAGC>; Wed, 6 Feb 2002 19:06:02 -0500
Received: from smtpinterno.wanadoo.es ([62.37.236.140]:25774 "EHLO
	smtp.wanadoo.es") by vger.kernel.org with ESMTP id <S290966AbSBGAFw> convert rfc822-to-8bit;
	Wed, 6 Feb 2002 19:05:52 -0500
Date: Thu,  7 Feb 2002 01:06:42 +0100
Message-Id: <GR4YZ6$IaNaxbYS7pHDy2KXFL5wNL4Sbf6iJS4Wb@wanadoo.es>
Subject: Kernel hotplug
MIME-Version: 1.0
X-Priority: 1 (Highest)
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
From: "mumismo" <mumismo@wanadoo.es>
To: linux-kernel@vger.kernel.org
X-XaM3-API-Version: 1.1.11.1.6
X-SenderIP: 62.83.13.194
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWD:
Hi
I just want to ask if someone is working or has worked in changing a kernel 
for another one without the need of rebooting the machine
I think it has a couple of practical purporses:
- Letting add new features as new drivers for hotplug devices , you can argue 
that compilation of modules are enough but think in big kernel number changes 
when you can't use that drivers so you have to reboot to install a new usb 
HW. Pretty windows-like...
- Letting change kernel for instance 2.4.0 --> 2.4.17, maybe you have a 
machine working fine but with some problems sometimes with memory and you 
have realized that the 2.4.17 mm works much finer. It's logical be able to 
change it without rebooting (maybe you are in a 24x7 enviroment or you want 
to beat some uptime record)

I think Solaris has this feature, i think Linux can have it too.
If someone have some technical guidance about this issue, have working in it, etc. Please tell me.

--
Jordi
_____________________________________________________________________
!REGALO GRATIS sólo por participar¡ Gana un premio seguro y exóticos 
viajes participando en el Rallye Wanadoo en http://www.wanadoo.es/animacion/rallye


