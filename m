Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTLJHDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 02:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTLJHDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 02:03:03 -0500
Received: from AGrenoble-101-1-4-231.w217-128.abo.wanadoo.fr ([217.128.202.231]:27776
	"EHLO awak") by vger.kernel.org with ESMTP id S262540AbTLJHDB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 02:03:01 -0500
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
From: Xavier Bestel <xavier.bestel@free.fr>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xvfop257d.fsf@kth.se>
References: <1070963757.869.86.camel@nomade>
	 <Pine.LNX.4.44.0312091358210.21314-100000@gaia.cela.pl>
	 <20031209183001.GA9496@kroah.com>  <yw1xvfop257d.fsf@kth.se>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1071039765.1790.94.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Dec 2003 08:02:46 +0100
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 09/12/2003 à 19:53, Måns Rullgård a écrit :
> >> - for example my floppy is always present in the system, but I access
> >> it like once a month or so
> >
> > Then, when you want to access it, a simple 'modprobe floppy' would work
> > for you, right?
> 
> Only if you are root.

Come on ... the stock kernel from your distribution will do the modprobe
for you when you access the floppy, I'm sure you're skilled enough to
configure your own kernel to do the same.
And if you don't want to recompile, just chmod +s modprobe - on your
small machine which needs to save 60k, I bet you're the only user. Or
use sudo.

	Xav

