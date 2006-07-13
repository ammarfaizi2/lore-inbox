Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbWGMXhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWGMXhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWGMXhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:37:15 -0400
Received: from xenotime.net ([66.160.160.81]:4228 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161046AbWGMXhN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:37:13 -0400
Date: Thu, 13 Jul 2006 16:40:01 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Gustavo Guillermo =?ISO-8859-1?B?UOlyZXo=?= 
	<gustavo@compunauta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pentium D on GW fail to boot with 2.6.16/17 but not with
 2.6.11/12/13/14/15
Message-Id: <20060713164001.959407d3.rdunlap@xenotime.net>
In-Reply-To: <200607131825.13989.gustavo@compunauta.com>
References: <200607111906.06343.gustavo@compunauta.com>
	<200607112104.03673.gustavo@compunauta.com>
	<20060711195401.1045c8dd.rdunlap@xenotime.net>
	<200607131825.13989.gustavo@compunauta.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2006 18:25:13 -0500 Gustavo Guillermo Pérez wrote:

> El Martes, 11 de Julio de 2006 21:54, escribió:
> > On Tue, 11 Jul 2006 21:04:02 -0500 Gustavo Guillermo Pérez wrote:
> > > booting kernel 2.6.15 with all drivers compiled, and loading Intelfb
> > > agp-intel the oops appears, I'm using an extra NVidia card.
> > >
> > > Deleting the intel810 and friends the oops disappear.
> >
> > Can you capture any oops messages?  (without using any
> > proprietary drivers)
> The bug appears at boot time, or at intel frame buffer loading, no drivers 
> loaded until the oops, but I'll try again.

OK, thanks.

> I can use a serial port, but I can't remember who? did you?

how?  Documentation/serial-console.txt

---
~Randy
PS:  What is "GW"?
