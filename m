Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVCGM7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVCGM7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 07:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVCGM7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 07:59:34 -0500
Received: from innocence.nightwish.hu ([217.20.130.196]:43402 "EHLO
	innocence.nightwish.hu") by vger.kernel.org with ESMTP
	id S261166AbVCGM7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 07:59:31 -0500
Subject: Re: NMI watchdog question
From: Pallai Roland <dap@mail.index.hu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200503071016.j27AGnDm016062@harpo.it.uu.se>
References: <200503071016.j27AGnDm016062@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Mar 2005 14:00:33 +0100
Message-Id: <1110200433.8018.189.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2005-03-07 at 11:16 +0100, Mikael Pettersson wrote:
> On Sun, 06 Mar 2005 01:53:25 +0100, Pallai Roland wrote:
> > and voila, the box is dead, but without any message from the NMI
> >watchdog :(
> ...
> >Kernel command line: auto BOOT_IMAGE=l2611-1S0 ro nfsroot=192.168.4.254:/mnt/daproot,v3 ip=192.
> >168.4.5::192.168.4.254:255.255.255.0::eth0:none console=tty0 console=ttyS0,115200 nmi_watchdog=
> >1 3
> 
> Please try nmi_watchdog=2.

 tried, doesn't work.. much less NMI interrupts in /proc/interrupts this
time


--
 dap
