Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbUBWKNW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 05:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbUBWKNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 05:13:22 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:11528 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S261901AbUBWKNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 05:13:21 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1077531080@astro.swin.edu.au>
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
In-reply-to: <20040220004605.GD5590@mail.shareable.org>
References: <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org> <20040219182948.GA3414@mail.shareable.org> <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org> <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org> <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org> <20040219204853.GA4619@mail.shareable.org> <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org> <20040220000054.GA5590@mail.shareable.org> <Pine.LNX.4.58.0402191607490.2244@ppc970.osdl.org> <20040220004605.GD5590@mail.shareable.org>
X-Face: "$j_Mi4]y1OBC/&z_^bNEN.b2?Nq4#6U/FiE}PPag?w3'vo79[]J_w+gQ7}d4emsX+`'Uh*.GPj}6jr\XLj|R^AI,5On^QZm2xlEnt4Xj]Ia">r37r<@S.qQKK;Y,oKBl<1.sP8r,umBRH';vjULF^fydLBbHJ"tP?/1@iDFsKkXRq`]Jl51PWN0D0%rty(`3Jx3nYg!
Message-ID: <slrn-0.9.7.4-12407-19306-200402232111-tc@hexane.ssi.swin.edu.au>
Date: Mon, 23 Feb 2004 21:13:16 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> said on Fri, 20 Feb 2004 00:46:05 +0000:
> One thing you can't do is real-time updatedb+locate, because of the
> need to have an open file descriptor for every directory that's monitored.

That would be so sweet (I hate that 2 hour long slocate run every
morning). It'd also help those of us who like our hd's to spin down,
but get confused by the zillions of lines output by laptop-mode (with
most of the changed "files" really coming from kjournald, etc) :)



-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
You see, wire telegraph is a kind of a very, very long cat. You pull
his tail in New York and his head is meowing in Los Angeles.  Do you
understand this?  And radio operates exactly the same way:  you send
signals here,  they receive them there.  The only difference is that
there is no cat.   -- Albie E. on radios. 
