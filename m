Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268022AbRHFMFd>; Mon, 6 Aug 2001 08:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268033AbRHFMFX>; Mon, 6 Aug 2001 08:05:23 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:27667 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S268022AbRHFMFW>; Mon, 6 Aug 2001 08:05:22 -0400
Date: Mon, 6 Aug 2001 14:04:59 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Emmanuel Varagnat <Emmanuel_Varagnat-AEV010@email.mot.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS file corruption
In-Reply-To: <3B6E84A1.1A13969@crm.mot.com>
Message-ID: <Pine.LNX.4.33.0108061404090.1209-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Emmanuel Varagnat wrote:

> 
> Today, I crashed the kernel and after reboot the source file
> I was working on, was completly unreadable. The size indicated
> by 'ls' seems to be good but with bad data.
> 
> Is this behavior normal (because the FS seems correct) ?
> The worst I hoped is loosing the last save, but not everything.
> 
> Must I patch to a newer version ?
> I'm using a 2.4.3 version.

I would certainly upgrade to 2.4.7. There are know reiserfs trouble in 
2.4.3 - and 2.4.7 is a lot more stable than 2.4.3.

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] ---------------------------------------
Is there anything else I can contribute?
The latitude and longtitude of the bios writers current position, and
a ballistic missile.
                                                          -- Alan Cox
--------------------------------- [ moffe at amagerkollegiet dot dk ] --

