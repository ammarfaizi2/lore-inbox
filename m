Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312444AbSDNTcz>; Sun, 14 Apr 2002 15:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312446AbSDNTcy>; Sun, 14 Apr 2002 15:32:54 -0400
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:63711 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S312444AbSDNTcy>; Sun, 14 Apr 2002 15:32:54 -0400
Message-ID: <3CB9D940.8040303@wanadoo.fr>
Date: Sun, 14 Apr 2002 21:32:16 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020407
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: spyro@armlinux.org
CC: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG*
In-Reply-To: <20020414004022.6450f038.spyro@armlinux.org>	<20020414150719.GA17826@kroah.com>	<20020414183247.016a2ec3.spyro@armlinux.org>	<20020414164355.GA18040@kroah.com>	<3CB9D20C.30000@wanadoo.fr> <20020414202113.12136578.spyro@armlinux.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Molton wrote:
> Its a VIA based board, and it /is/ an add-on card. its a 4 port OPTi based
> card.

 From FAQ on Alcatel site:

Q11: My modem often powers down without any reason and I have to reboot 
to connect again.

A11: This is a known problem with motherboards using the VIA chipset. 
Always install the latest Via4in1 drivers and USB filter from the Via 
website. If you have a Motherboard of the KT7 type, one workaround is to 
change the BIOS settings: set the 'enhanced chipset performance' setting 
on 'enable'. This should help in most cases. For more information about 
the KT7 / VIA chipset issues with USB, you may read the the ViaHardware 
  FAQ pages or the USBman page.


Pierre
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

