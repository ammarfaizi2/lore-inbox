Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVEXUA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVEXUA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 16:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVEXUA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 16:00:56 -0400
Received: from jaragua.fcav.unesp.br ([200.145.101.9]:32736 "EHLO
	jaragua.fcav.unesp.br") by vger.kernel.org with ESMTP
	id S261986AbVEXUAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 16:00:38 -0400
Message-ID: <429389DA.7080408@fcav.unesp.br>
Date: Tue, 24 May 2005 17:08:58 -0300
From: Marcelo Luiz de Laia <mlaia@fcav.unesp.br>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with optical mouse PS/2 on Linux 2.6.8.1-kanotix-10
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Previous to send, I send this question to my native language debian 
mailing (Brazilian Portuguese) and, after breaf answers, I send it to 
the debian-users mailing lists, as well the first, I receive a few 
answers. Then, I post this questions on a forum and I dont get any 
replay. In this mean time, I do a lot of search on google linux 
http://www.google.com/linux. On google, I found this thread 
http://www.ussg.iu.edu/hypermail/linux/kernel/0406.2/1498.html and I 
suspect that are the some problem or maybe very closed problem. I am not 
subscribed on kernel.org mailling. This mail is my "parting breath" on 
this problem.

I receive answers like this: change your mouse..." But, am very curious 
and I suspect that I woudl get knowledg after solve this question. But, 
I am send my apologizes if this problem is very simple.

The problem:

When the system is on boot up, when peripherals are be detected, the 
light of my mouse is turned off. Then, my mouse didin't is recognized by 
Xserver.

I suppose that I have a problem with my kernel, because the red lights 
(laser) is turned off as soon as the next message is showed on the 
screen in the start up system:

mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1


*Then, my problem don't is with the X configuration, it appear before 
the X start.*

I read these thread 
http://www.ussg.iu.edu/hypermail/linux/kernel/0406.2/1498.html but I 
dont know how I do that suggestions: compile a new kernel? How version? 
A patch?

Any one could be tell me what I do in this case? Or suggest me another 
maillist or maintainer?

When I use another optical mouse, it is detected as:

input: ImPS/2 Generic Wheel Mouse on isa0060/serio1

and it works fine!

I use Debian-like Linux 2.6.8.1-kanotix-10 #1 Sun Oct 31 19:57:19 BRT 
2004 i686 GNU/Linux

PS.: ImExPS/2 mouse is different from ImPS/2 mouse!? I suppose that here 
are the problem.

Thanks

Marcelo
