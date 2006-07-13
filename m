Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWGMXZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWGMXZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWGMXZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:25:16 -0400
Received: from compunauta.com ([69.36.170.169]:46523 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S1161037AbWGMXZP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:25:15 -0400
From: Gustavo Guillermo =?iso-8859-1?q?P=E9rez?= 
	<gustavo@compunauta.com>
Organization: www.compunauta.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: Pentium D on GW fail to boot with 2.6.16/17 but not with 2.6.11/12/13/14/15
Date: Thu, 13 Jul 2006 18:25:13 -0500
User-Agent: KMail/1.8.2
References: <200607111906.06343.gustavo@compunauta.com> <200607112104.03673.gustavo@compunauta.com> <20060711195401.1045c8dd.rdunlap@xenotime.net>
In-Reply-To: <20060711195401.1045c8dd.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607131825.13989.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Martes, 11 de Julio de 2006 21:54, escribió:
> On Tue, 11 Jul 2006 21:04:02 -0500 Gustavo Guillermo Pérez wrote:
> > booting kernel 2.6.15 with all drivers compiled, and loading Intelfb
> > agp-intel the oops appears, I'm using an extra NVidia card.
> >
> > Deleting the intel810 and friends the oops disappear.
>
> Can you capture any oops messages?  (without using any
> proprietary drivers)
The bug appears at boot time, or at intel frame buffer loading, no drivers 
loaded until the oops, but I'll try again.

I can use a serial port, but I can't remember who? did you?

-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
