Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbTH2Pbs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 11:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTH2Pbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 11:31:48 -0400
Received: from 212088093130.sonofon.dk ([212.88.93.130]:28934 "HELO
	212088093130.sonofon.dk") by vger.kernel.org with SMTP
	id S261357AbTH2Pbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 11:31:37 -0400
Message-ID: <51DDD38845C4D31182D900508BE185B7F0777C@DKCOPMAIL01>
From: Kristian Spangsege <kristian.spangsege@framfab.dk>
To: "'Kronos '" <kronos@kronoz.cjb.net>,
       Kristian Spangsege <kristian.spangsege@framfab.dk>
Cc: "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>
Subject: RE: Radeon 9800 support by framebuffer subsystem in kernel 2.6.x
Date: Fri, 29 Aug 2003 17:31:24 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perfect :-)

And thanks for you tips 

-----Original Message-----
From: Kronos
To: Kristian Spangsege
Cc: linux-kernel@vger.kernel.org
Sent: 8/29/2003 5:23 PM
Subject: Re: Radeon 9800 support by framebuffer subsystem in kernel 2.6.x

Nell'articolo <pKCA.6Hh.35@gated-at.bofh.it> hai scritto:
> Hi Ani

The new maintainer is Benjamin Herrenschmidt.

> I have noticed that the Radeon 9800 chipset is now supported by the
> framebuffer subsystem ("drivers/video/radeonfb.c") in the latest 2.4
> kernels. That is nice, thanks :-)
> But I also noticed that the chipset it is not supported in the latest
2.6
> test kernels.
> Do you have any idea when this support will be added?

Very soon. It's just a matter of adding some PCI IDs. Read
linux-fbdev-devel@lists.sourceforge.net to see what's going on :)

Luca
-- 
Home: http://kronoz.cjb.net
"La teoria e` quando sappiamo come funzionano le cose ma non funzionano.
 La pratica e` quando le cose funzionano ma non sappiamo perche`.
 Abbiamo unito la teoria e la pratica: le cose non funzionano piu` e non
 sappiamo il perche`." -- A. Einstein
