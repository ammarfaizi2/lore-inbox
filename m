Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbTE0TvQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTE0TvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:51:15 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27042 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264073AbTE0Tuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:50:52 -0400
Date: Tue, 27 May 2003 17:01:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Oliver Pitzeier <o.pitzeier@uptime.at>
Cc: "'Willy Tarreau'" <willy@w.ods.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
In-Reply-To: <000d01c3242b$4dd31a60$020b10ac@pitzeier.priv.at>
Message-ID: <Pine.LNX.4.55L.0305271701430.9487@freak.distro.conectiva>
References: <000d01c3242b$4dd31a60$020b10ac@pitzeier.priv.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Oliver Pitzeier wrote:

> Willy Tarreau <willy@w.ods.org> wrote:
> > On Tue, May 27, 2003 at 01:35:09AM +0100, Alan Cox wrote:
> >
> > > One thing I will say however - I'd have done the *same* thing as
> > > Marcelo with aic7xxx during -rc which is to defer it.
> >
> > I think you would at least have forwarded problem reports to
> > Justin, expecting him to look into the problem first.
>
> As the one who started this discussion... I'd simply like to quote this and say:
>
> _FULL_ ack!
>
> [ ... ]
>
> I also changed the whole server (the one which had the aix7xxx problems) in the
> meantime... Changed the Adaptec 2940, now there is a Adaptec 29160. I switched
> from a Dual-P3 to a P4. And well, the interessting part, I switched from
> 2.4.20(-XX) to 2.4.19. EVERYTHING runs faster and stable now!

Oliver,

Does 2.4.21-rc5 work for you?
