Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTE0EgB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTE0EgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:36:01 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:50877 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263340AbTE0Ef7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:35:59 -0400
Date: Tue, 27 May 2003 01:47:13 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Willy Tarreau <willy@w.ods.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       gibbs@scsiguy.com, acme@conectiva.com.br
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
In-Reply-To: <20030527043936.GB19309@alpha.home.local>
Message-ID: <Pine.LNX.4.55L.0305270144300.546@freak.distro.conectiva>
References: <1053732598.1951.13.camel@mulgrave> <20030524064340.GA1451@alpha.home.local>
 <1053923112.14018.16.camel@rth.ninka.net> <1053995708.17151.42.camel@dhcp22.swansea.linux.org.uk>
 <20030527043936.GB19309@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Willy Tarreau wrote:

> On Tue, May 27, 2003 at 01:35:09AM +0100, Alan Cox wrote:
>
> > One thing I will say however - I'd have done the *same* thing as Marcelo
> > with aic7xxx during -rc which is to defer it.
>
> I think you would at least have forwarded problem reports to Justin,
> expecting him to look into the problem first.

Justin used to say "use my latest driver" when people reported problems.
Read lkml.

Its great if Justins new driver fixes the problems, but as I told him I
thought it was too late for it to be included. Thats my bad, too, because
if I had included it early in 2.4.21pre it could be in now.

Justin could well have fixed the problems in the current driver instead
answering "use my latest driver", couldnt he?
