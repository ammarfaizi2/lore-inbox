Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281959AbRKZRvl>; Mon, 26 Nov 2001 12:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281966AbRKZRvV>; Mon, 26 Nov 2001 12:51:21 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:13579 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S281959AbRKZRvQ>;
	Mon, 26 Nov 2001 12:51:16 -0500
Message-ID: <3C028113.4090305@epfl.ch>
Date: Mon, 26 Nov 2001 18:51:15 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Yom, Francis" <fyom@symmsys.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: AGPGART oops
In-Reply-To: <29800F5ABF5EAC42998190CFF1846AA303C6A4@symlab0-srvr1.SYMMETRY.SYMMSYS.COM>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yom, Francis wrote:

> Dear Nicolas,
> 
> Thanks for your quick reply!  I cannot run lspci :-/  There is a bug in
> Debian that makes lcpci error out saying:
> 
> 	pcilib: Cannot open /proc/bus/pci/03/00.1
> 	lspci: Unable to read 64 bytes of configuration space.
> 
> I don't know if there is a fix for it yet.
> 
> I'm running 2.4.14 on Debian on a Compaq Presario 2701T laptop.  It has
> a Radeon M chipset.
> 

Yikes... I think I saw this kind of bug report on linux-kernel recently 
but I think it has been fixed now... maybe you should try to upgrade 
your kernel to the latest (2.4.16) and see what it gives...

a+
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)


