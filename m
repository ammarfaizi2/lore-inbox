Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284933AbRLZUy4>; Wed, 26 Dec 2001 15:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284924AbRLZUyr>; Wed, 26 Dec 2001 15:54:47 -0500
Received: from tourian.nerim.net ([62.4.16.79]:12562 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S284899AbRLZUyf>;
	Wed, 26 Dec 2001 15:54:35 -0500
Message-ID: <3C2A38D5.3090309@free.fr>
Date: Wed, 26 Dec 2001 21:53:41 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011220
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: [RFC] SIS5513 ATA100 support
In-Reply-To: <3C27B02B.7070804@free.fr> <3C28CFEA.1010808@free.fr>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm back with new code.

This one doesn't work on my sis735 either :-( but after having 
triple-checked my code I don't see why :-((. Time to show the code to 
others...

If someone familiar with pci-ide code could just take a quick look...

The goal is only working ata-100 inits. There's code in sis5513.c that 
could use a little cleanup but I'll wait working ata-100 inits to work 
on that.

You have an edited (commented) diff from original sis5513.c and the real 
patch attached.

A complete new sis5513.c is available for more conveniance at :
http://gyver.homeip.net/sis5513.c

LB.

