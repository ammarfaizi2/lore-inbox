Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSAGV7w>; Mon, 7 Jan 2002 16:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287235AbSAGV7d>; Mon, 7 Jan 2002 16:59:33 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:15050 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287204AbSAGV7b>; Mon, 7 Jan 2002 16:59:31 -0500
Message-ID: <3C3A1A31.C08DC913@folkwang-hochschule.de>
Date: Mon, 07 Jan 2002 22:59:13 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier 
	<nettings@folkwang-hochschule.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Johannes Erdfelt <johannes@erdfelt.com>
CC: linux-kernel@vger.kernel.org, nettings@folkwang-hochschule.de
Subject: Re: 2.4.17 usbnet usb.c: USB device not accepting new address
In-Reply-To: <3C3A0B1A.6441FC74@folkwang-hochschule.de> <3C3A0E29.99650F60@folkwang-hochschule.de> <20020107161544.J10145@sventech.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt wrote:
> 
> It's not responding to the SETUP packet. I'd check the cable, or maybe
> the connector on the motherboard.
> 
> Does it enumerate in Windows?

i don't have windows available for testing.

i just checked on a powerbook g3 using the ohci driver, and i get
the same errors as with uhci.o on my intel.
which rules out the mobo connector.

the cable is a slightly wobbly cradle, but this model works fine for
others.
no matter how i press or tilt the ipaq, the error is the same (i.e.
no intermittent contacts obviously). 

could it possibly be anything else ?

are there any measurements i can do on the cable ?
i would expect to have two +/- voltage supplies and two data wires.





-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/
