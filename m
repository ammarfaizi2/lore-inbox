Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281788AbRK0WoQ>; Tue, 27 Nov 2001 17:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282961AbRK0WoD>; Tue, 27 Nov 2001 17:44:03 -0500
Received: from AGrenoble-101-1-7-32.abo.wanadoo.fr ([80.13.189.32]:59521 "EHLO
	strider.virtualdomain.net") by vger.kernel.org with ESMTP
	id <S281788AbRK0Wnl> convert rfc822-to-8bit; Tue, 27 Nov 2001 17:43:41 -0500
Message-ID: <3C041805.2060509@wanadoo.fr>
Date: Tue, 27 Nov 2001 23:47:33 +0100
From: =?ISO-8859-15?Q?Fran=E7ois?= Cami <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Dax Kelson <dax@gurulabs.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: onboard ethernet/sound on Soyo SY-K7V?
In-Reply-To: <Pine.LNX.4.33.0111271514320.28301-100000@mooru.gurulabs.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson wrote:

> I'm looking a purchasing a dozen computers with the Soyo SY-K7V Dragon 
> Plus motherboard.  It has the KT266A chipset.
> 
> My question is Linux support for the onboard ethernet and sound.  I've 
> googled all over and haven't come up with a definitive answer.
> 
> They are described as "VIA 10/100 Ethernet" and "CMI 8738 Audio chip".


CMI 8738 has a driver in the current kernel.
As for VIA 10/100 Ethernet, I dunno... Maybe the via-rhine would work ?
Not sure, though...

François


 > Does anyone know the scoop?
 >
 > Dax


