Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbSK3N44>; Sat, 30 Nov 2002 08:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267247AbSK3N44>; Sat, 30 Nov 2002 08:56:56 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:6299 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267245AbSK3N4z>; Sat, 30 Nov 2002 08:56:55 -0500
Subject: Re: Massive problems with 2.4.20 module loading
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Loschwitz <madkiss@madkiss.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021130084940.GA4534@minerva.local.lan>
References: <20021130084940.GA4534@minerva.local.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Nov 2002 14:36:57 +0000
Message-Id: <1038667017.17199.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-30 at 08:49, Martin Loschwitz wrote:
> Hello Marcelo, hello world,
> 
> I'm having massive problems with Linux 2.4.20 and modul loading. In fact,
> it seems to have something to do with devfs. Everytime i try to load a
> module which is supposed to create something new in /dev, i get an Oops.
> I noticed that behaviour with vmware-module and now also with ALSA 
> 0.9.0rc6. Is there a fix available for this yet?

Linux 2,4.20 doesnt include vmware or ALSA. The fact you list those
modules alone suggests that the problem is that you haven't rebuilt them
for the new kernel


