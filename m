Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbUDESh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 14:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbUDESh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 14:37:59 -0400
Received: from dns.communicationvalley.it ([212.239.58.133]:25805 "HELO
	rose.communicationvalley.it") by vger.kernel.org with SMTP
	id S263129AbUDESh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 14:37:57 -0400
From: Biker <biker@villagepeople.it>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5, ACPI, suspend and ThinkPad R40
Date: Mon, 5 Apr 2004 20:37:52 +0200
User-Agent: KMail/1.6.1
References: <Pine.LNX.4.53.0402191116550.500@chaos>
In-Reply-To: <Pine.LNX.4.53.0402191116550.500@chaos>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404052037.53306.biker@villagepeople.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> I have an IBM ThinkPad R40...

Me too,
(model number 2681-BDG) and since the release of 2.6.0 many things have been 
sligthly getting worse or never worked at all.

-It used to suspend/resume correctly until 2.6.3, but afterwards reboots 
during resume.
-Unplugging a usb bluetooth dongle oopses the machine since 2.6.4 (used to 
work ok before).
-The radeon fb drivers both have little problems (garbled screen, last screen 
line not updated correctly)...
-The pcmcia controller does not work correctly (it stays dead if a pccard is 
plugged in after bootup, I need to restart the pcmcia services to make it 
work again).
-I never succeded in making infrared work, however it works fine under 2.4.

I'm very willing to help all the kernel hackers out there to solve these 
problems, please contact me, I can run whatever test/patch/hack you might 
throw at me.

Regards, Biker.
