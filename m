Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbTEJQk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTEJQk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:40:57 -0400
Received: from mail.gmx.de ([213.165.64.20]:58777 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264444AbTEJQk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:40:56 -0400
Date: Sat, 10 May 2003 18:51:18 +0200
From: Tuncer M "zayamut" Ayaz <tuncer.ayaz@gmx.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
In-Reply-To: <20030510162527.GD29271@mail.jlokier.co.uk>
References: <1405.1052575075@www9.gmx.net>
	<1052575167.16165.0.camel@dhcp22.swansea.linux.org.uk>
	<S264332AbTEJO5e/20030510145734Z+7011@vger.kernel.org>
	<S264373AbTEJPSN/20030510151813Z+1648@vger.kernel.org>
	<20030510162527.GD29271@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <S264444AbTEJQk4/20030510164056Z+1652@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 May 2003 17:25:27 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> Tuncer M zayamut Ayaz wrote:
> > what I found out right now is that when there is
> > load (moving mailer windows around) the sound
> > is gone and reappears if there's no load aka
> > I stop moving mailer window (while typing this mail).
> 
> That's the opposite of my Toshiba in any of the lower power modes.
> 
> When there's CPU activity, it emits a quiet high-pitched noise.  When
> CPU activity stops, the noise stops.  This doesn't happen in the
> maximum power usage mode (brigh screen, fastest clock), and I don't
> know if there's a way to turn it off.

1) with SpeedStep enabled in BIOS and also enabled with software
switching to full-speed mode turn down the volum a bit.

2) disabled SpeedStep in BIOS. init-scripts enabled speed step
same behaviour as in 1)

funny side is that prior to booting 2.5 on the LILO prompt
I listened and would bet that the same noise but very very
quietly was still there.
