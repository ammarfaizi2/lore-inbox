Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273533AbRIQI12>; Mon, 17 Sep 2001 04:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273534AbRIQI1J>; Mon, 17 Sep 2001 04:27:09 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:46725 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S273533AbRIQI0y>; Mon, 17 Sep 2001 04:26:54 -0400
Message-ID: <3BA5B3A8.5080008@korseby.net>
Date: Mon, 17 Sep 2001 10:26:16 +0200
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Magnus Naeslund(f)" <mag@fbab.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IBM DTLA IDE Made In Hungary
In-Reply-To: <12ca01c13f3b$e1ee8490$020a0a0a@totalmef>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I experienced problems with their 40 GB and 75 GB variants. The first one was 
made in Thaiwan. So it isn't really a matter from where they're coming from.
I'm testing right now. I have applied a special crc-patch and a self-made patch. 
The problems didn't appeared again yet. I'm also testing with UDMA modes. The 
drives are coming with UDMA 5 enabled, but linux and my board are'nt supporting 
it. So I downspeeded them with IBM's Feature Tool. I first experienced faults 
with linux>=2.4.5-ac12. Mostly the errors appeared after a boot in the morning 
as the drive was down for hours and cold too.

But I don't own any RAID-controllers. I have just a simple UDMA2-controller. 
Maybe these faults are only occuring in connection with my specific hardware. I 
don't know.

So if you hadn't had any problems before you're disks would be safe for now.

Magnus Naeslund(f) wrote:

> A while ago I read about these drives on lkml.
> Someone was experiencing problems with them, and now I am too.
> We have a sh*tload of systems using these in a Promise SuperTrak IDE RAID
> setups.
> So we have 8raid*6drives running over here, and I'm afraid that they will
> start falling apart.

> 
> Does anyone have any info on these problems ?
> URL:s, pointers, whatever?
> Has IBM said anything about this?
> 
> Should I demand that the company selling these drives to us exhange those
> for some other brand, or what?
> 
> Cheers
> 
> Magnus


·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                          :: http://www.korseby.net
                          :: http://www.tomlab.de
kristian@korseby.net ....::

