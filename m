Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbTFRTmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 15:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbTFRTmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 15:42:42 -0400
Received: from vopmail.neto.com ([209.223.15.78]:53772 "EHLO vopmail.neto.com")
	by vger.kernel.org with ESMTP id S265298AbTFRTml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 15:42:41 -0400
Message-ID: <3EF0B68D.4020203@neto.com>
Date: Wed, 18 Jun 2003 13:59:25 -0500
From: John T Copeland <johnc@neto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030315
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre H <andre@linux-ide.org>,
       linuxkernel <linux-kernel@vger.kernel.org>
Subject: sil3112-siimage dma problems - 2.4.21 kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having the same problems with the siimage driver as those posted in 
the thread "siimage driver status".  Also I read all the posts on the 
siimage driver.

My motherboard is an Abit NF7-S rev2.0, nforce2 chipset and SIL3112A 
controller.  I tried the "hdparm -d1 -X66 /dev/hde" trick but I get the 
dma timer error, siimage reset message, and the system repeats these 
messages.  Finally, after a long delay I get all kinds of io errors 
reported from my ext3 journal and filesystem.  At this point I have to 
reset the system and reboot, back into the PIO mode.  I don't know 
anything else to try.  Help.

I am running the 2.4.21 kernel.

I will send any additional info required if I can, and act as a test 
case for the Abit NF7-S board.  Most posts seem to be on the Asus mobo.
JohnC


