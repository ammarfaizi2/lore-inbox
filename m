Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbTICQ4t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbTICQ4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:56:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:58240 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264131AbTICQ4q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:56:46 -0400
Date: Wed, 3 Sep 2003 12:58:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alberto Manuel =?ISO-8859-1?Q?Brand=E3o_Sim=F5es?= 
	<albie@alfarrabio.di.uminho.pt>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems compiling kernel 2.4.22
In-Reply-To: <1062607884.623.23.camel@eremita.di.uminho.pt>
Message-ID: <Pine.LNX.4.53.0309031257410.28170@chaos>
References: <1062606509.623.20.camel@eremita.di.uminho.pt>
 <1062607884.623.23.camel@eremita.di.uminho.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Alberto Manuel [ISO-8859-1] Brandão Simões wrote:


> On Wed, 2003-09-03 at 17:28, Alberto Manuel Brandão Simões wrote:
> > [1.] One line summary of the problem:
> >  modules symbols broken references
> >
> > [2.] Full description of the problem/report:
> >  when I make 'make modules_install' I get:
> >  depmod: *** Unresolved symbols in /lib/modules/2.4.22/kernel/net/ipv4/ipip.o
> >  depmod:         ip_send_check
> >  depmod:         register_netdevice
> >  ..
> >
> > and so on, and not only for these modules: vfat, smbfs, msdos, etc
> >
> > By the way, when I tried to ssh to paste more information, I got in the
> > console:

[SNIPPED...]

BYW. Did you try booting the new system, THEN, executing `depmod -a` ?


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


