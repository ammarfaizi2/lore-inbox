Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131248AbRCNBGi>; Tue, 13 Mar 2001 20:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131252AbRCNBG2>; Tue, 13 Mar 2001 20:06:28 -0500
Received: from [195.63.194.11] ([195.63.194.11]:12555 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131248AbRCNBGL>; Tue, 13 Mar 2001 20:06:11 -0500
Message-ID: <3AAECF17.727656A2@evision-ventures.com>
Date: Wed, 14 Mar 2001 02:53:27 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>, npsimons@fsmlabs.com,
        Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
In-Reply-To: <Pine.LNX.4.21.0103131951590.2056-100000@imladris.rielhome.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 13 Mar 2001, Albert D. Cahalan wrote:
> 
> > Bloat removal: being able to run without /proc mounted.
> >
> > We don't have "kernel speed". We have kernel-mode screwing around
> > with text formatting.
> 
> Sounds like you might want to maintain an external patch
> for the embedded folks...

Not the embedded folks!!! The server folks laugh histerically
all times they go via ssh to a trashing busy box to see what's wrong
and then they see top or ps auxe under linux never finishing they job:


> 
> regards,
> 
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
>                 http://www.surriel.com/
> http://www.conectiva.com/       http://distro.conectiva.com.br/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
