Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbSJAMYz>; Tue, 1 Oct 2002 08:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261598AbSJAMYz>; Tue, 1 Oct 2002 08:24:55 -0400
Received: from sc-grnvl-66-169-5-131.chartersc.net ([66.169.5.131]:3456 "EHLO
	rhino.thrillseeker.net") by vger.kernel.org with ESMTP
	id <S261595AbSJAMYx>; Tue, 1 Oct 2002 08:24:53 -0400
Subject: Re: Linux 2.4.20-pre8-ac3
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200209302029.g8UKTfG12427@devserv.devel.redhat.com>
References: <200209302029.g8UKTfG12427@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Oct 2002 08:30:16 -0400
Message-Id: <1033475417.641.2.camel@rhino.thrillseeker.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
> o	Further CPUfreq updates		(Gerald Britton, H Peter Anvin
> 					 Dominik Brodowski)
...

I consistently get the following compile error:

speedstep.c: In function `speedstep_detect_chipset':
speedstep.c:297: `PCI_DEVICE_ID_INTEL_82815_MC' undeclared (first use in
this function)
speedstep.c:297: (Each undeclared identifier is reported only once
speedstep.c:297: for each function it appears in.)
make[1]: *** [speedstep.o] Error 1

Billy

