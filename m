Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316263AbSEVRQ3>; Wed, 22 May 2002 13:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316265AbSEVRQ2>; Wed, 22 May 2002 13:16:28 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:54187 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S316264AbSEVRQ1>; Wed, 22 May 2002 13:16:27 -0400
Message-Id: <200205221711.g4MHBKI08352@colombe.home.perso>
Date: Wed, 22 May 2002 19:11:17 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: nVidia NIC/IDE/something support?
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E17AVxU-0001bm-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22 Mai, Alan Cox a écrit :
>> nvidia help for swsusp would be nice also. I tried the patch on my
>> desktop for the first time and it seems to work reliably (even from X)
>> except that 3D is lost after resume. That's rather curious: menus
>> without highlights or things like that.
> 
> I've seen a few machines where you have to reinitialize the GART. Thats
> where the pm hooks for the agpgart code came from. That may be worth a try.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I'll give it a try since that's exactly what I did for my i810 laptop
chipset. 

--
Florent Chabaud
http://www.ssi.gouv.fr | http://fchabaud.free.fr

