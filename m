Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129847AbRCCXUB>; Sat, 3 Mar 2001 18:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129855AbRCCXTl>; Sat, 3 Mar 2001 18:19:41 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:60197 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129847AbRCCXTg>; Sat, 3 Mar 2001 18:19:36 -0500
Date: Sun, 4 Mar 2001 00:19:07 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        Kernel list <kernel@linux-mandrake.com>
Subject: Re: [PATCH] 2.4.2: cure the kapm-idled taking (100-epsilon)% CPU
 time
In-Reply-To: <E14ZLG0-0004I5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0103040016050.922-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2001, Alan Cox wrote:

> 
> > As attachment. Don't ask me why it works. Rather, if you see why it works, I'd
> > like to know why :)
> 
> Why are you breaking kapm-idled. It is supposed to take all that cpu time. You
> just broke all the power saving
> 

Well, from reading the source, I don't see how this can break APM... What am I
missing?

-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

