Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274167AbRISUbZ>; Wed, 19 Sep 2001 16:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274169AbRISUbQ>; Wed, 19 Sep 2001 16:31:16 -0400
Received: from anime.net ([63.172.78.150]:59408 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S274167AbRISUbD>;
	Wed, 19 Sep 2001 16:31:03 -0400
Date: Wed, 19 Sep 2001 13:30:36 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: <brian@worldcontrol.com>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Athlon bug stomper: perf. results
In-Reply-To: <20010919133539.A11184@top.worldcontrol.com>
Message-ID: <Pine.LNX.4.30.0109191329170.27640-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001 brian@worldcontrol.com wrote:
> Linux 2.4.9ac5 *without* althon bug stomper patch:
>     oopes to death on boot.

And without kernel athlon optimization, please.

It should be clear: run the athlon.c on a kernel WITHOUT athlon kernel
optimization, but with the 'athlon bug stomper patch' on and off.

-Dan

-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

