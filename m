Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbTLJUGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 15:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263914AbTLJUGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 15:06:25 -0500
Received: from dyn-213-36-224-2.ppp.tiscali.fr ([213.36.224.2]:9476 "EHLO
	nsbm.kicks-ass.org") by vger.kernel.org with ESMTP id S263913AbTLJUGX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 15:06:23 -0500
Date: Wed, 10 Dec 2003 21:06:14 +0100
From: Witukind <witukind@nsbm.kicks-ass.org>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: mru@kth.se, linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-Id: <20031210210614.625ccfcc.witukind@nsbm.kicks-ass.org>
In-Reply-To: <1071039765.1790.94.camel@nomade>
References: <1070963757.869.86.camel@nomade>
	<Pine.LNX.4.44.0312091358210.21314-100000@gaia.cela.pl>
	<20031209183001.GA9496@kroah.com>
	<yw1xvfop257d.fsf@kth.se>
	<1071039765.1790.94.camel@nomade>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Dec 2003 08:02:46 +0100
Xavier Bestel <xavier.bestel@free.fr> wrote:

> Le mar 09/12/2003 à 19:53, Måns Rullgård a écrit :
> > >> - for example my floppy is always present in the system, but I
> > >access> it like once a month or so
> > >
> > > Then, when you want to access it, a simple 'modprobe floppy' would
> > > work for you, right?
> > 
> > Only if you are root.
> 
> Come on ... the stock kernel from your distribution will do the
> modprobe for you when you access the floppy, I'm sure you're skilled
> enough to configure your own kernel to do the same.
> And if you don't want to recompile, just chmod +s modprobe - on your
> small machine which needs to save 60k, I bet you're the only user. Or
> use sudo.
> 
> 	Xav

I was expecting this kind of reply. Like "if you have an older hardware you
can fuck off".

-- 
Jabber: heimdal@jabber.org
