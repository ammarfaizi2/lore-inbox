Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277550AbRJETIa>; Fri, 5 Oct 2001 15:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277551AbRJETIU>; Fri, 5 Oct 2001 15:08:20 -0400
Received: from zeus.kernel.org ([204.152.189.113]:9099 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S277550AbRJETIG>;
	Fri, 5 Oct 2001 15:08:06 -0400
Date: Fri, 5 Oct 2001 14:41:00 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Igor Mozetic <igor.mozetic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac4 (SMP, highmem) complete freeze
In-Reply-To: <15293.65326.541017.774801@cmb1-3.dial-up.arnes.si>
Message-ID: <Pine.LNX.4.21.0110051436560.2744-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Oct 2001, Igor Mozetic wrote:

> The same story as with 2.4.10, only faster:
> 
> After one day of uptime under load 2-3 (highmem),
> the box froze completely. Only hard reboot (actually power unplug)
> brought it back. Nothing in logs, nothing over netconsole-C2 ...

Can you try to get any backtraces the next time the machine locks up ?

You can use the SysRQ key's for that (documentation about it at
Documentation/sysrq.txt). (Alt+SysRQ+T and Alt+SysRQ+P traces)

Thanks 

