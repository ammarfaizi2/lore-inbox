Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTE0Erj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTE0Erj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:47:39 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:65031 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263355AbTE0Eri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:47:38 -0400
Date: Tue, 27 May 2003 07:00:30 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@redhat.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gibbs@scsiguy.com, acme@conectiva.com.br
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Message-ID: <20030527050030.GA19948@alpha.home.local>
References: <1053732598.1951.13.camel@mulgrave> <20030524064340.GA1451@alpha.home.local> <1053923112.14018.16.camel@rth.ninka.net> <1053995708.17151.42.camel@dhcp22.swansea.linux.org.uk> <20030527043936.GB19309@alpha.home.local> <Pine.LNX.4.55L.0305270144300.546@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305270144300.546@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 01:47:13AM -0300, Marcelo Tosatti wrote:
 
> Justin used to say "use my latest driver" when people reported problems.
> Read lkml.

I agree, but honnestly, when a driver author remembers about hundreds of bugs
fixed between the version the user complains about and the last one, it's
difficult to point the real problem, and then to say to this people "just
apply this little fix for this particular bug, and cross your fingers not to
be caught by the 99 others".

> Justin could well have fixed the problems in the current driver instead
> answering "use my latest driver", couldnt he?

I think he could have tried to fix the most obvious ones and then say
"Marcelo, my old driver is plain buggy, here are a few fixes for the
complainers, but it's about to explode, please plan on a full upgrade soon".

Anyway, what is done is done. It's nonsense always talking about the past,
we'd all better spend our time fixing bugs.

Regards,
Willy

