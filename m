Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261405AbTCOF7X>; Sat, 15 Mar 2003 00:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbTCOF7X>; Sat, 15 Mar 2003 00:59:23 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:9344 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261405AbTCOF7W>; Sat, 15 Mar 2003 00:59:22 -0500
Message-ID: <3E72C390.9CF1A9ED@cinet.co.jp>
Date: Sat, 15 Mar 2003 15:09:20 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.64-ac4-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.61 (14/26) input
References: <20030217134333.GA4734@yuzuki.cinet.co.jp> <20030217141223.GN4799@yuzuki.cinet.co.jp> <20030314092248.A27902@ucw.cz>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> On Mon, Feb 17, 2003 at 11:12:23PM +0900, Osamu Tomita wrote:
> 
> > This is patchset to support NEC PC-9800 subarchitecture
> > against 2.5.61 (14/26).
> >
> > Drivers for PC98 standard keyboard/mouse.
> 
> Thanks, applied.
Thanks.
Please check my patch agaist 2.5.64 I posted. That has update
(only one line) to syncronize parameter change of interrupt
function.

Regards,
Osamu Tomita
