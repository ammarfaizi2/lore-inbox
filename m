Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVBGSCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVBGSCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 13:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVBGSCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:02:18 -0500
Received: from [128.8.126.38] ([128.8.126.38]:63494 "EHLO www.missl.cs.umd.edu")
	by vger.kernel.org with ESMTP id S261212AbVBGSCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:02:15 -0500
Date: Mon, 7 Feb 2005 13:04:22 -0500 (EST)
From: Adam Sulmicki <adam@cfar.umd.edu>
X-X-Sender: adam@www.missl.cs.umd.edu
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
cc: Paulo Marques <pmarques@grupopie.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Li-Ta Lo <ollie@lanl.gov>
Subject: Re: [RFC] Reliable video POSTing on resume
In-Reply-To: <42077CFD.7030607@gmx.net>
Message-ID: <Pine.BSF.4.62.0502071259500.26868@www.missl.cs.umd.edu>
References: <e796392205020221387d4d8562@mail.gmail.com>  <420217DB.709@gmx.net>
 <4202A972.1070003@gmx.net>  <20050203225410.GB1110@elf.ucw.cz> 
 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> 
 <1107485504.5727.35.camel@desktop.cunninghams>  <9e4733910502032318460f2c0c@mail.gmail.com>
  <20050204074454.GB1086@elf.ucw.cz>  <9e473391050204093837bc50d3@mail.gmail.com>
  <20050205093550.GC1158@elf.ucw.cz> <1107695583.14847.167.camel@localhost.localdomain>
 <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu> <42077AC4.5030103@grupopie.com>
 <42077CFD.7030607@gmx.net>
X-WEB: http://www.eax.com
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005, Carl-Daniel Hailfinger wrote:

> And how many competing implementations of video helpers/emulation code
> do we have now?
>
> - scitechsoft emu
> - linuxbios emu
> - etc. (I surely forgot some)

just a minor nit-pick. "linuxbios" is not an "emulator" but drop-in 
replacement for commerical bios (on motherboards that are supported).

 	http://www.linuxbios.org/

I belive Paulo Marques and Li-Ta Lo expands linuxbios with the emulator to 
run the VIDEOBIOS contained in it, but, it just an add on.
