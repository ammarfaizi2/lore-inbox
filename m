Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293121AbSCEOBr>; Tue, 5 Mar 2002 09:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293125AbSCEOBi>; Tue, 5 Mar 2002 09:01:38 -0500
Received: from [216.66.12.254] ([216.66.12.254]:21461 "HELO
	ep1.elevenprospect.com") by vger.kernel.org with SMTP
	id <S293121AbSCEOBd>; Tue, 5 Mar 2002 09:01:33 -0500
Message-ID: <3C84CF95.8070103@xblox.net>
Date: Tue, 05 Mar 2002 14:00:53 +0000
From: Matthew Allum <mallum@xblox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020205
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: fujitsu pt510 ( again ) and touchscreen
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all;

I now have Linux running happily on the 510 with pcmcia and X running 
happily.

However I am having little luck getting any infomation from the 
touchscreen. I have tried various X11 drivers ( from linuxslate.org 
andfujitsu b112 drivers ) as well as kernel modules for different types 
of ps2 mice. 

Im not sure if the touchscreen is on a ttyS or /dev/psaux, the kernel 
reports nothing. I have been told ( unreliably however ) thats its a ps2 
port on irq 12. Catting these various devices also produces nothing.

Im looking for some pointers on how to begin reverse enginneeing the 
touchscreen and
actually getting some data from it.

dmidecode gives me nothing as does lspci ( the machine does not have pci ).

Any advice, greatly appreciated;

Matthew Allum


