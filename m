Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263704AbTDGVrX (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTDGVrW (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:47:22 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:32009 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S263704AbTDGVq0 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 17:46:26 -0400
Date: Mon, 7 Apr 2003 23:57:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Roman Zippel <zippel@linux-m68k.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <Pine.LNX.4.44.0304071742490.12110-100000@serv>
Message-ID: <Pine.LNX.4.44.0304072351110.12110-100000@serv>
References: <200303311541.50200.pbadari@us.ibm.com> <Pine.LNX.4.44.0304031256550.5042-100000@serv>
 <20030403133725.GA14027@win.tue.nl> <Pine.LNX.4.44.0304031548090.12110-100000@serv>
 <b6s3tm$i2d$1@cesium.transmeta.com> <Pine.LNX.4.44.0304071742490.12110-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 7 Apr 2003, Roman Zippel wrote:

> Consequently it's impossible that the kernel guarantees a static name/ 
> number for a specific device. devfs showed that the kernel is the wrong 
> place for name policies. Is see no other possibility than to number 
> devices dynamically and leave it to userspace to name them or did I miss 
> an important point in previous discussions?
> Maybe you could also answer me, what exactly you need a 64bit dev_t for?

Ok, Peter refuses to give me an answer to that, this either means I'm 
unworthy an answer or he doesn't know it either.
Is there really nobody who can answer me these questions?

bye, Roman

