Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbUJaCmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUJaCmo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 22:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbUJaCmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 22:42:44 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:29968 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S261480AbUJaCmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 22:42:42 -0400
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Tim Connors <tconnors+linuxkernel1099190446@astro.swin.edu.au>
Subject: Re: [OT] Re: code bloat [was Re: Semaphore assembly-code bug]
In-reply-to: <Pine.LNX.4.58.0410310155080.11293@ppg_penguin.kenmoffat.uklinux.net>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>  <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>  <20041030222720.GA22753@hockin.org>  <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>  <1099178405.1441.7.camel@krustophenia.net> <1099176751.25194.12.camel@localhost.localdomain> <Pine.LNX.4.58.0410310155080.11293@ppg_penguin.kenmoffat.uklinux.net>
X-test-to: Ken Moffat <ken@kenmoffat.uklinux.net>
X-cc-to: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>, Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>, Tim Hockin <thockin@hockin.org>, Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-reply-to-bofh-messageid: <2Vcy3-7un-13@gated-at.bofh.it>
X-Face: +*%dmR:3=9i\[:8fga\UgZT#@`f=DU0(wQqI'AR2/r0sBMO}Ax\,V*cWaW-owRlUmuz&=v\KItx0:gRCBg1&z_"4x&-N#Di7))]~p2('`6|5.c3&:Z?VLU`Zt5Kb,~uC6<y}P'~7A+^'|'+iAd4t43:P;tPiT<q=9P$MO]u^@OHn1_4#qP7,XiSo21SkgI`:5=i$,t&uNN_\LfuLyH`)8!:Tb]Z
Message-ID: <slrn-0.9.7.4-21646-32676-200410311340-tc@hexane.ssi.swin.edu.au>
Date: Sun, 31 Oct 2004 13:42:34 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Moffat <ken@kenmoffat.uklinux.net> said on Sun, 31 Oct 2004 01:09:54 +0000 (GMT):
> and the time to load it is irrelevant.  Since then I've had an anecdotal
> report that -Os is known to cause problems with gnome.  I s'pose people
> will say it serves me right for doing my initial testing on ppc which
> didn't have this problem ;)  The point is that -Os is *much* less tested
> than -O2 at the moment.

Because people suck, and don't use it and hence test it.

Ie, test it!

I can't, because I prefer to stay away from gnome instead.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
"Warning: Do not look into laser with remaining eye" -- a physics experiment
"Press emergency laser shutdown button with remaining hand" -- J.D.Baldwin @ ASR
