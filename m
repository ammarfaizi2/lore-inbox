Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136454AbRD3GcB>; Mon, 30 Apr 2001 02:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136452AbRD3Gbw>; Mon, 30 Apr 2001 02:31:52 -0400
Received: from [62.225.179.11] ([62.225.179.11]:29198 "EHLO mail.pol.degrp.de")
	by vger.kernel.org with ESMTP id <S136454AbRD3Gbe> convert rfc822-to-8bit;
	Mon, 30 Apr 2001 02:31:34 -0400
Message-ID: <9DD550E9A9B0D411A16700D0B7E38BA42BC99F@mail.degrp.org>
From: "Antwerpen, Oliver" <Antwerpen@netsquare.org>
To: linux-kernel@vger.kernel.org
Subject: RE: Sony Memory stick format funnies... 
Date: Mon, 30 Apr 2001 08:31:44 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moin,

> -----Original Message-----
> From: mirabilos [mailto:eccesys@topmail.de]
> Sent: Sunday, April 29, 2001 1:07 AM
> To: linux-kernel@vger.kernel.org; Rogier Wolff
> Subject: Re: Sony Memory stick format funnies... 
> 
> 
> Yn....).........
> > 04e30  00 00 00 00 00 00 46 41   54 31 32 20 20 20 00 00 ......FAT12
> ..
> > 04ff0  00 00 00 00 00 00 00 00   00 00 00 00 00 00 55 aa
> ..............U*
> 
> I didnt look further but IMO it must be PARTITIONED???
> (I'd start the partition at +1 rather than +0x27)
> 

Right, it is partitioned. And the dcim-dir is created by the camera during
formatting...

Olli

-- 
Die Wahrheit liegt irgendwo da drauﬂen...
