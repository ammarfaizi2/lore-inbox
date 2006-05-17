Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWEQXo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWEQXo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 19:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWEQXo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 19:44:57 -0400
Received: from mailhost.terra.es ([213.4.149.12]:10110 "EHLO
	csmtpout2.frontal.correo") by vger.kernel.org with ESMTP
	id S1750704AbWEQXo4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 19:44:56 -0400
Date: Wed, 17 May 2006 19:33:57 +0200 (added by postmaster@terra.es)
From: grundig <grundig@teleline.es>
To: "Felipe Alfaro Solana" <felipe.alfaro@gmail.com>
Cc: jesper.juhl@gmail.com, linuxcbon@yahoo.fr, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
Message-Id: <20060517194438.1df682aa.grundig@teleline.es>
In-Reply-To: <6f6293f10605171017y106565ev62683f04b353a2f5@mail.gmail.com>
References: <200605171218.k4HCIt4L013978@turing-police.cc.vt.edu>
	<20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
	<9a8748490605170639n12fde7c9i836599f02a30fd51@mail.gmail.com>
	<6f6293f10605171017y106565ev62683f04b353a2f5@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 17 May 2006 19:17:12 +0200,
"Felipe Alfaro Solana" <felipe.alfaro@gmail.com> escribió:

> > And when the windowing system crashes it'll take the kernel down with it - ouch.
> >
> > And if I want to run a headless server without a graphical display I
> > can't simply stop the windowing system I'd have to rebuild a kernel
> > without the windowing system in it - yuck.
> 
> Ey! That's very familiar to me and it's called Windows.

Windows XP and 2003 support headless mode. I don't think it's particulary
difficult to do it, just implement a /dev/null graphics driver.


Oh BTW, Windows is getting their graphics subsystem out of the kernel
(except the drivers of course) in Vista. The perfect time for people
to start useless rants on whether Linux should include a graphic subsystem
in the kernel. 
