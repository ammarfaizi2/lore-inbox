Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbTIAKwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 06:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTIAKwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 06:52:05 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:730 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S262823AbTIAKwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 06:52:00 -0400
Message-ID: <3F5324C7.8030709@ihme.org>
Date: Mon, 01 Sep 2003 13:51:51 +0300
From: =?ISO-8859-1?Q?Markus_H=E4stbacka?= <midian@ihme.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en, fi
MIME-Version: 1.0
To: Martin Zwickel <martin.zwickel@technotrend.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Weird problem with nforce2
References: <3F4F54F2.4080506@ihme.org> <20030829163958.5c327d6d.martin.zwickel@technotrend.de>
In-Reply-To: <20030829163958.5c327d6d.martin.zwickel@technotrend.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, I got it working now, thank you anyways. I got another problem 
straight ahead too.
My AGP works, but it's darn slow. I need it working probebly so I can 
use my linux again *sigh*.
I have a Nforce 2 chipset on my board. If I build Nforce2 support as a 
module or built in it causes a hang, and I need a hard reboot. I saw 
that if the module is loaded at startup it will cause a crash, but if I 
load it later, it wont affect the speed. So, it needs to be loaded in 
bootup, but it will cause a crash, you know something about this? When 
starting X it just crashes (And I can reproduce this without taining the 
kernel) so is Nforce2 support broken for my board?

Regards,
---
Markus Hästbacka <midian@ihme.org>

