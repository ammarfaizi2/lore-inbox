Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284010AbRLAIsS>; Sat, 1 Dec 2001 03:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284008AbRLAIsA>; Sat, 1 Dec 2001 03:48:00 -0500
Received: from ns.caldera.de ([212.34.180.1]:9885 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S284009AbRLAIrp>;
	Sat, 1 Dec 2001 03:47:45 -0500
Date: Sat, 1 Dec 2001 09:47:38 +0100
Message-Id: <200112010847.fB18lcc21966@ns.caldera.de>
From: Marcus Meissner <mm@ns.caldera.de>
To: dervishd@jazzfree.com (Ra?lN??ez de Arenas	 Coronado),
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Enhancement of /proc/partitions output (2.5.1-pre5)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <E16A5XI-0005Lr-00@DervishD.viadomus.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16A5XI-0005Lr-00@DervishD.viadomus.com> you wrote:
>     Hello Anton :)

>>Please consider below patch which adds the starting sector and number of
>>sectors to /proc/partitions.

>     This is a *great* idea. I was wondering why this information is
> not included by default :)))

>     I have a somewhat 'special' partition scheme and that information
> is vital for me. Thanks a lot for the patch. I hope that Marcello
> accepts it for 2.4.17...

Marcelo, don't apply to this to 2.4, a lot of userland applications rely
on it.

Ciao, Marcus
