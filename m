Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTITUJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 16:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTITUJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 16:09:29 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:44160 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261953AbTITUJ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 16:09:28 -0400
Date: Sat, 20 Sep 2003 21:09:22 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux@treblig.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2[12] v VIA Rhine and VIA82x audio (working with a fight)
Message-ID: <20030920200922.GC8953@mail.jlokier.co.uk>
References: <20030920163835.GA723@gallifrey> <1064079929.22995.7.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064079929.22995.7.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Except for playing CDs - which don't do anything - I suspect that might
> > be hardware, but am not sure.
> 
> Check there is an analog cable fitted on the CD->Sound. Many new WinXP
> boxes are shipped with XP configured to digitally rip the CD data and no
> audio link cable. If so you need to pick a different CD player app or
> fit the cable.

Different hardware, possibly similar problem.

I'm using the cmipci driver for sound.  On a 2.4.18 kernel, CD audio
is mixed fine from the analogue cable.

On a 2.5.75 kernel, I don't hear anything from the analogue input.
There is a CD audio mixer setting, but adjusting it doesn't produce any sound.

Therefore I have digitally rip CDs to play them on 2.5.75, but not on 2.4.18.

Cheers,
-- Jamie

