Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261336AbRE0Ja5>; Sun, 27 May 2001 05:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbRE0Jas>; Sun, 27 May 2001 05:30:48 -0400
Received: from line59.dialup.graz.inode.at ([195.58.172.63]:47849 "HELO
	wuffi.grazforyou.at") by vger.kernel.org with SMTP
	id <S261336AbRE0Ja3>; Sun, 27 May 2001 05:30:29 -0400
Message-ID: <3B10C922.2060504@grazforyou.at>
Date: Sun, 27 May 2001 11:30:10 +0200
From: Fritz Ganter <ganter@grazforyou.at>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre1 i686; de-AT; rv:0.9) Gecko/20010505
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: OV511 in 2.4.5 doesn't compile
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The file ov511 in 2.4.5 doesn't compile because there is an undefined 
variable "version" in line 340. I replaced this with the #defined 
DRIVER_VERSION.

-- 
Fritz "der mit dem Linux tanzt" Ganter         http://www.kraftvoll.at
Linux Consulting & Training                 http://www.linuxexperts.at
Graz for you - der Grazer Stadtserver         http://www.grazforyou.at
A-8010 Graz,  Liebiggasse 19/3/14           Tel. +43 (0)699 110 21 621

