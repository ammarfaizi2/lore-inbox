Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279064AbRKMMc7>; Tue, 13 Nov 2001 07:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281521AbRKMMct>; Tue, 13 Nov 2001 07:32:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61448 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279064AbRKMMcn>; Tue, 13 Nov 2001 07:32:43 -0500
Subject: Re: SiS630 and 5591/5592 AGP
To: gavbaker@ntlworld.com (Gavin Baker)
Date: Tue, 13 Nov 2001 12:40:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, sgy@amc.com.au (Stuart Young)
In-Reply-To: <20011113122033.A9379@box.penguin.power> from "Gavin Baker" at Nov 13, 2001 12:20:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163crX-000139-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Im using your patched sis_drv.o for X now. The performance increase is
> noticable, but the Xv display still can't keep up with any highbandwidth video
> (even 352x288 mpeg), so my dream of DVD playback is still far off but a lot
> closer. ;)

For the SiS 6326 you want mtrr's set up to make it write combining and
ideally the new Xvmc X11 support not just Xv
