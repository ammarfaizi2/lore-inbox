Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264941AbUFTEQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUFTEQn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 00:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUFTEQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 00:16:30 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:64266 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S263875AbUFTEQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 00:16:28 -0400
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1087704856@astro.swin.edu.au>
Subject: Re:  linux-2.6.7-bk2 runs faster than linux-2.6.7 ;)
In-reply-to: <200406200431.44576.volker.hemmann@heim9.tu-clausthal.de>
References: <200406200431.44576.volker.hemmann@heim9.tu-clausthal.de>
X-Face: "0\RuOFb6AcQ}B_F/^%;;AmS%><zZ_q?N1w1%1voDY7#Ywj~qRaL7].8HB'2~pDUS|{E=$R\-s?;+p!RCe:w||kS\T@[(eQHB*-8u;~)ZP4;QYUI`|GJ)NS\`jLbW<e'R*y+Od,S5D+Vz++a<[$g'>"qr*^0t%eriBMe_x]B7&@b8_\i<A/A@T
Message-ID: <slrn-0.9.7.4-20609-28380-200406201414-tc@hexane.ssi.swin.edu.au>
Date: Sun, 20 Jun 2004 14:16:18 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de> said on Sun, 20 Jun 2004 04:31:44 +0200:
> Hi,
> 
> I have the same problem.
> 
> Everything seems to be double speed. The keys, the little moving icon in th=
> e=20
> top right off the konqueror window  and the cursor is blinking like mad.=20
> glxgears fps are halved, like the fps in  unreal tournament 2004 demo.
> 
> There everything was incredidbly fast, but fps halved.

You realise that FPS has the "per second" part as measured by the
computer, right? And what will happen if the computer thinks a second
takes less time?

Of course FPS will go down, but the real Frames per Human-Second
probably hasn't changed at all.


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
If I'd known computer science was going to be like this, I'd never have
given up being a rock 'n' roll star.                -- G. Hirst
