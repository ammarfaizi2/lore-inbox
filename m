Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTF0JEW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 05:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTF0JEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 05:04:22 -0400
Received: from albatross-ext.wise.edt.ericsson.se ([193.180.251.49]:16310 "EHLO
	albatross.tn.sw.ericsson.se") by vger.kernel.org with ESMTP
	id S263749AbTF0JEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 05:04:20 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Miklos.Szeredi@eth.ericsson.se (Miklos Szeredi)
Date: Fri, 27 Jun 2003 11:18:13 +0200 (MEST)
Message-Id: <200306270918.h5R9IDn08937@duna48.eth.ericsson.se>
To: Alex Belits <abelits@phobos.illtel.denver.co.us>
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA Ezra CentaurHauls
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   First board worked perfectly until I have started (as a regular user)
> RealPlayer 8. After that the box became unstable, and other applications
> (mozilla, mplayer, gcc) started to crash randomly with SEGV. However I
> have not seen a kernel crash.

I had very similar experiences with the same CPU: VIA Ezra Stepping 8
(see: http://marc.theaimsgroup.com/?t=104262312700003&r=1&w=2).  And
that was not with an EPIA, but an ASUS CUV4X-C MB.

I had the processor replaced, because I narrowed the problem down to
that, but it didn't help.  

My feeling is ever stronger as I see these posts, that it is really
this modell that is buggy.  If that is true, then VIA should either
replace these CPUs with a non-buggy one, or find a workaround for
whatever operating systems are affected.

BTW, I could reliably cure this broblem by turning off the L2 cache in
BIOS.  Maybe it is some memory interaction problem, but I'm not an
expert on this subject.

Miklos
