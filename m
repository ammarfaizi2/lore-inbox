Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbTAUGvS>; Tue, 21 Jan 2003 01:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265995AbTAUGvS>; Tue, 21 Jan 2003 01:51:18 -0500
Received: from relief.getitback.org ([208.49.116.17]:18961 "EHLO
	relief.getitback.org") by vger.kernel.org with ESMTP
	id <S265987AbTAUGvP>; Tue, 21 Jan 2003 01:51:15 -0500
Date: Tue, 21 Jan 2003 02:00:19 -0500
From: Paul <set@pobox.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Spurious 8259A interrupt: IRQ7 ????
Message-ID: <20030121070019.GL16611@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <3E2C8EFF.6020707@tin.it> <3E2C9623.60709@sktc.net> <3E2CD91B.2080305@tupshin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E2CD91B.2080305@tupshin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tupshin Harper <tupshin@tupshin.com>, on Mon Jan 20, 2003 [09:22:35 PM] said:
> David D. Hagood wrote:
> 
> >It is most likely a hardware problem.
> >
> I wouldn't necessarily assume a hardware problem (unless we also include 
> chipset oddities). I get *exactly* one message stating exactly this per 
> boot, and it always come a few seconds after loading the parport and 
> parport_pc modules.
> 
> one example:
> Jan 20 09:20:21 testing kernel: parport0: PC-style at 0x378 [PCSPP,EPP]
> Jan 20 09:20:21 testing kernel: parport_pc: Via 686A parallel port: io=0x378
> <snip>
> Jan 20 09:20:07 testing kernel: spurious 8259A interrupt: IRQ7.
> 
> -Tupshin
> 

	Hi;

	I see it just once every boot, and I dont have any parallel
port stuff enabled. (2.5.59)

Paul
set@pobox.com
