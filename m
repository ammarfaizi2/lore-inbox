Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261681AbSJMUUN>; Sun, 13 Oct 2002 16:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261698AbSJMUUM>; Sun, 13 Oct 2002 16:20:12 -0400
Received: from zork.zork.net ([66.92.188.166]:44252 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S261681AbSJMUUM>;
	Sun, 13 Oct 2002 16:20:12 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.42
References: <Pine.LNX.4.44L.0210131755340.22735-100000@imladris.surriel.com>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Message-Flag: Message text advisory: SLOTHFUL INDUCTION, EXCRETORY SPEECH
X-Mailer: Norman
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Alameda: : WHY DOESN'T ANYONE KNOW ABOUT ALAMEDA?  IT'S RIGHT NEXT TO
 OAKLAND!!!
Organization: The Emadonics Institute
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sun, 13 Oct 2002 21:26:03 +0100
In-Reply-To: <Pine.LNX.4.44L.0210131755340.22735-100000@imladris.surriel.com> (Rik
 van Riel's message of "Sun, 13 Oct 2002 17:57:06 -0200 (BRST)")
Message-ID: <6uit06ytk4.fsf@zork.zork.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Rik van Riel quotation:

> All you need is:
>
> 1) a kernel level driver that can map devices, ie. a device mapper
>
> 2) user space tools that can parse the volume metadata and tell the
>    kernel how to map each chunk at initialisation or mount time
>
> You don't need a flying circus in kernel space.

I don't know my arse from my elbow when it comes to kernel design and
coding issues, but my chimpanzee brain really likes this aspect of the
LVM2/dm combination.

-- 
 /                          |
[|] Sean Neakums            |  Questions are a burden to others;
[|] <sneakums@zork.net>     |      answers a prison for oneself.
 \                          |
