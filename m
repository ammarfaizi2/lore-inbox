Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTJ2VDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 16:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTJ2VDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 16:03:38 -0500
Received: from mail-4.tiscali.it ([195.130.225.150]:2480 "EHLO
	mail-4.tiscali.it") by vger.kernel.org with ESMTP id S261563AbTJ2VDh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 16:03:37 -0500
Date: Wed, 29 Oct 2003 22:03:21 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>,
       "Javier Villavicencio" <jvillavicencio@arnet.com.ar>
Subject: Re: RadeonFB [Re: 2.4.23pre8 - ACPI Kernel Panic on boot]
Message-ID: <20031029210321.GA11437@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FA01DB6.6080106@enterprise.bidmc.harvard.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I guess the newer 0.1.8 is needed to support Radeon 9600's.  I'm curious 
> as to whether other people have the same massive screen corruption 
> problems returning from X as I do.  If not, probably best to keep the 
> new driver.  (Maybe I should go out and buy myself a new Radeon. :-)  I 
> have been using ATI's private DRI/DRM kernel module driver (fglrx) in 
> concert with XFree 4.2.0 for quite some time.

Ah! ATI's driver touches registers behind our back. Can you reproduce
without this binary module?

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Al termine di un pranzo di nozze mi hanno dato un
amaro alle erbe cosi' schifoso che perfino sull'etichetta
c'era un frate che vomitava.
