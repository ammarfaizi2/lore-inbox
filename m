Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbTBULnb>; Fri, 21 Feb 2003 06:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267394AbTBULnb>; Fri, 21 Feb 2003 06:43:31 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53615 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267393AbTBULna>; Fri, 21 Feb 2003 06:43:30 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302211153.h1LBrYR12271@devserv.devel.redhat.com>
Subject: Re: Linux 2.5.62-ac1
To: tomita@cinet.co.jp (Osamu Tomita)
Date: Fri, 21 Feb 2003 06:53:34 -0500 (EST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org '),
       alan@redhat.com ('Alan Cox ')
In-Reply-To: <E6D19EE98F00AB4DB465A44FCF3FA46903A340@ns.cinet.co.jp> from "Osamu Tomita" at Feb 21, 2003 02:37:37 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Linux 2.5.62-ac1
> > o	PC-9800 update			(Osamu Tomita)
> Thanks!
> 
> > o	Toshiba keyboard workaround		(Pavel Machek)
> This change conflict with PC98 keyboard. Always shows message
> 'Keyboard glitch detected, ignoring keypress' every keypress.
> Other machine has no problem?

I've had no other reports of it triggering wrongly. Thats easy to
deal with. Pavel can you send me the dmidecode data for the afflicted
laptop ?
