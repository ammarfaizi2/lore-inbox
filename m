Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUHGKSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUHGKSl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 06:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUHGKSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 06:18:41 -0400
Received: from tarjoilu.luukku.com ([194.215.205.232]:5537 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S261184AbUHGKSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 06:18:39 -0400
Message-ID: <4114AC9D.B63C00C0@users.sourceforge.net>
Date: Sat, 07 Aug 2004 13:19:09 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       James Morris <jmorris@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.6.8-rc3 - BSD licensing
References: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
		     <1091644663.21675.51.camel@ghanima> <Pine.LNX.4.58.0408041146070.24588@ppc970.osdl.org>
		     <1091647612.24215.12.camel@ghanima> <Pine.LNX.4.58.0408041251060.24588@ppc970.osdl.org>
		   <411228FF.485E4D07@users.sourceforge.net> <Pine.LNX.4.58.0408050941590.24588@ppc970.osdl.org>
		 <411353B3.B8748556@users.sourceforge.net> <Pine.LNX.4.58.0408060918320.24588@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Fri, 6 Aug 2004, Jari Ruusu wrote:
> > Linus, you are mixing two completely different rights here;
> > re-distribution right and re-licensing right.
> 
> Ehh.. You're wrong.

Yep. I goofed.

> You haven't even read the GPL, have you?

I read it in 1995. Obviously too many years have passed since then.

> So when you claim that the code isn't GPL-compatible, and at the same time
> claim that we can't re-license it under the GPL, you are very very
> confused indeed. Either it is GPL-compatible, or it is not. And if it is
> GPL-compatible, that ABSOLUTELY means that it can be relicensed under the
> GPL.

Yep. I don't have any other choice here than to permit re-licencing the
code. My 04-Aug-2004 18:04:46 +0300 posting where I denied re-licencing
right was completely wrong. I'm sorry about that.

For loop-AES users I uploaded a patch here that updates licenses to be
GPL-compatible:  http://loop-aes.sourceforge.net/updates/aes-GPL.diff

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
