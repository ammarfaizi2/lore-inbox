Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130800AbRBLAim>; Sun, 11 Feb 2001 19:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130806AbRBLAid>; Sun, 11 Feb 2001 19:38:33 -0500
Received: from pille.addcom.de ([62.96.128.34]:40974 "HELO pille.addcom.de")
	by vger.kernel.org with SMTP id <S130800AbRBLAiR>;
	Sun, 11 Feb 2001 19:38:17 -0500
Date: Mon, 12 Feb 2001 01:39:59 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Kurt Roeckx <Q@ping.be>
cc: <linux-kernel@vger.kernel.org>, BaRT <bart11@dingoblue.net.au>
Subject: Re: OOPS with 2.4.1-ac8
In-Reply-To: <20010211154253.A484@ping.be>
Message-ID: <Pine.LNX.4.30.0102120122430.1155-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2001, Kurt Roeckx wrote:

> I suddenly started to get those oopses.  It didn't seem to cause
> any problems tho.

> Feb 11 15:04:01 Q kernel: Call Trace: [cached_lookup+14/80]
> [path_walk+1337/1944] [getname+91/152] [__user_walk+58/84] 
> [sys_newstat+21/108]
> [system_call+51/64]  

This looks similar to an Oops posted by BaRT a couple of days ago. Out of 
curiosity, are you using ISDN, too? The oops doesn't seem to be related to 
the ISDN code AFAICS, but on the other hand you never know ;)

--Kai




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
