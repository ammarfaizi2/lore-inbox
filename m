Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262441AbSJVKn0>; Tue, 22 Oct 2002 06:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbSJVKn0>; Tue, 22 Oct 2002 06:43:26 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:54498 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262441AbSJVKnY>;
	Tue, 22 Oct 2002 06:43:24 -0400
Date: Tue, 22 Oct 2002 12:49:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCHSET 13/25] add support for PC-9800 architecture (keyboard)
Message-ID: <20021022124926.C21346@ucw.cz>
References: <20021019015636.A1588@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021019015636.A1588@precia.cinet.co.jp>; from tomita@cinet.co.jp on Sat, Oct 19, 2002 at 01:56:36AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 01:56:36AM +0900, Osamu Tomita wrote:
> This is part 13/26 of patchset for add support NEC PC-9800 architecture,
> against 2.5.43.
> 
> Summary:
>  console keyboard modules
>   - adapted to PC-9800 hardware spec.
>   - add jis-x201("kana") support.
> 
> diffstat:
>  drivers/char/defkeymap_pc9800.c   |  285 ++++++++++++++++++++++++
>  drivers/char/defkeymap_pc9800.map |  439 ++++++++++++++++++++++++++++++++++++++
>  drivers/char/keyboard.c           |   79 ++++++
>  include/linux/kbd_kern.h          |   11 
>  include/linux/keyboard.h          |    4 
>  include/linux/logibusmouse.h      |   30 ++
>  include/linux/pc_keyb.h           |   18 +
>  7 files changed, 865 insertions(+), 1 deletion(-)

Still the same, see my previous mails.

-- 
Vojtech Pavlik
SuSE Labs
