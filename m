Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265995AbUBQFZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266019AbUBQFZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:25:47 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:12304 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265995AbUBQFZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:25:45 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1076995458@astro.swin.edu.au>
Subject: Re: UTF-8 and case-insensitivity
In-reply-to: <16433.38038.881005.468116@samba.org>
References: <16433.38038.881005.468116@samba.org>
X-Face: "$j_Mi4]y1OBC/&z_^bNEN.b2?Nq4#6U/FiE}PPag?w3'vo79[]J_w+gQ7}d4emsX+`'Uh*.GPj}6jr\XLj|R^AI,5On^QZm2xlEnt4Xj]Ia">r37r<@S.qQKK;Y,oKBl<1.sP8r,umBRH';vjULF^fydLBbHJ"tP?/1@iDFsKkXRq`]Jl51PWN0D0%rty(`3Jx3nYg!
Message-ID: <slrn-0.9.7.4-11486-5025-200402171624-tc@hexane.ssi.swin.edu.au>
Date: Tue, 17 Feb 2004 16:25:38 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tridge@samba.org said on Tue, 17 Feb 2004 15:12:06 +1100:
> Given how much pain the "kernel is agnostic to charset encoding"
> attitude has cost me in terms of programming pain, I thought I should
> de-cloak from lurk mode and put my 2c into the UTF-8 issue.
> 
> Personally I think that eventually the Linux kernel will have to
> embrace the interpretation of the byte streams that applications have
> given it,

What applications?

> despite the fact that this will be very painful and
> potentially quite complex. The reason is that I think that eventually
> the Linux kernel will need to efficiently support a userspace policy
> of case-insensitivity and the only way to do case-insensitive filename
> operations is to interpret those byte streams as a particular
> encoding.
> 
> Personally I much prefer the systems I use to be case-sensitive, but
> there are important applications that require case-insensitivity for
> interoperability. 

Why? Sounds pretty idiotic to me.

If you don't like it, using some microshit filesystem like vfat. I'll
keep using ext3 etc, thanks.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Conclusion to my thesis -- "It is trivial to show that it is 
clearly obvious that this is not woofly."
