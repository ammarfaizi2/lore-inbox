Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTLOGMk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 01:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTLOGMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 01:12:05 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:6413 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S263292AbTLOGJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 01:09:45 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1071468463@astro.swin.edu.au>
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
In-reply-to: <buo1xr6q15p.fsf@mcspd15.ucom.lsi.nec.co.jp>
References: <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade> <20031209090815.GA2681@kroah.com> <buoiskqfivq.fsf@mcspd15.ucom.lsi.nec.co.jp> <yw1xd6ayib3f.fsf@kth.se> <3FD5AB6C.3040008@aitel.hist.no> <20031212112636.GA12727@mail.shareable.org> <20031212163422.GA4051@helium.inexs.com> <yw1xr7zaymzp.fsf@kth.se> <buo1xr6q15p.fsf@mcspd15.ucom.lsi.nec.co.jp>
X-Face: "$j_Mi4]y1OBC/&z_^bNEN.b2?Nq4#6U/FiE}PPag?w3'vo79[]J_w+gQ7}d4emsX+`'Uh*.GPj}6jr\XLj|R^AI,5On^QZm2xlEnt4Xj]Ia">r37r<@S.qQKK;Y,oKBl<1.sP8r,umBRH';vjULF^fydLBbHJ"tP?/1@iDFsKkXRq`]Jl51PWN0D0%rty(`3Jx3nYg!
Message-ID: <slrn-0.9.7.4-11845-24817-200312151707-tc@hexane.ssi.swin.edu.au>
Date: Mon, 15 Dec 2003 17:09:40 +1100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader <miles@lsi.nec.co.jp> said on 15 Dec 2003 11:12:50 +0900:
> mru@kth.se (Måns Rullgård) writes:
> > Please, don't CC me.  I'm subscribed to linux-kernel and don't need
> > two copies of all mails.
> 
> You ought to put in one of those magic headers that says so (I don't see
> one in your messages, though maybe I overlooked something), as you can
> hardly expect everybody to remember who's subscribed to the list and
> who's not.
> 
> [No I don't remember what they are; I don't care about duplicate
> replies, in fact I _like_ duplicate replies (because it means I usually
> get a copy faster than what goes through the list reflector).]

And there's always procmail:

# avoid duplicate messages
:0 Whc: msgid.lock
| formail -D 16384 .msgid.cache

:0 a:
.duplicates


I do further processing to make sure that any replies direct to me
make it direct to me, instead of going into mailing list folder...

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
"Eddies in the space time continuum"
"Oh. Is he?"  -- Zem?
