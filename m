Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268116AbUHFJrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268116AbUHFJrI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 05:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUHFJrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 05:47:08 -0400
Received: from tarjoilu.luukku.com ([194.215.205.232]:7071 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP id S268116AbUHFJq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 05:46:56 -0400
Message-ID: <411353B3.B8748556@users.sourceforge.net>
Date: Fri, 06 Aug 2004 12:47:31 +0300
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
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> You're saying that you consider Gladman's original AES license to be
> GPL-compatible (ie a subset of it)? That's fine - apparently the FSF
> agrees.

Yes, it is GPL-compatible.

> However, that is incompatible with you then complaining when it gets
> released under the GPL. If the original license was a proper subset of the
> GPL, then it can _always_ be re-released under the GPL, and you don't have
> anything to complain about.

Linus, you are mixing two completely different rights here; re-distribution
right and re-licensing right. Original license grants you GPL-compatible
re-distribution rights, which means that the code can be distributed and
linked with GPL code just fine. To relicense the code under more restrictive
license you need permission from all authors of the code. You clearly do not
have such permission from all authors. Therefore, you can not re-license the
code.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
