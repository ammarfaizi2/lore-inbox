Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267357AbSKPVAe>; Sat, 16 Nov 2002 16:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbSKPVAe>; Sat, 16 Nov 2002 16:00:34 -0500
Received: from opengfs.tovarcom.com ([65.67.58.21]:27020 "HELO
	escalade.vistahp.com") by vger.kernel.org with SMTP
	id <S267357AbSKPVAe>; Sat, 16 Nov 2002 16:00:34 -0500
Message-ID: <20021116211036.22162.qmail@escalade.vistahp.com>
References: <20021116205613.GE28356@fs.tum.de>
In-Reply-To: <20021116205613.GE28356@fs.tum.de>
From: "Brian Jackson" <brian-kernel-list@mdrx.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5: Help for choice questions doesn't work
Date: Sat, 16 Nov 2002 15:10:36 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that too. It works on the top level choice(before you get into the 
selections). I was just thinking about suggesting to Roman that we could 
either show the same help all the way down in those multiple choice cases, 
or provide a link back up to the main help. Where it would actually show the 
text, but wouldn't repeat the same text 15 times(once for each choice). That 
functionality could probably come in handy in other cases too. I just don't 
know how hard that would be to implement. 

 --Brian Jackson 

Adrian Bunk writes: 

> In 2.5.47 the help for choice questions (e.g. "Processor family" or
> "High Memory Support" in the "Processor type and features" menu) doesn't
> work in "make menuconfig", there's always a "There is no help available
> for this kernel option." displayed. 
> 
> cu
> Adrian 
> 
> --  
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
 
