Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTEWLVA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 07:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbTEWLVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 07:21:00 -0400
Received: from mail.ithnet.com ([217.64.64.8]:53000 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264025AbTEWLU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 07:20:59 -0400
Date: Fri, 23 May 2003 13:33:38 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Oliver Pitzeier" <o.pitzeier@uptime.at>
Cc: darkshadow@web.de, marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Aix7xxx unstable in 2.4.21-rc2? (RE: Linux 2.4.21-rc2)
Message-Id: <20030523133338.658a83ad.skraw@ithnet.com>
In-Reply-To: <000001c3210e$3e04da30$020b10ac@pitzeier.priv.at>
References: <3ECDE94C.3030502@web.de>
	<000001c3210e$3e04da30$020b10ac@pitzeier.priv.at>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003 11:32:34 +0200
"Oliver Pitzeier" <o.pitzeier@uptime.at> wrote:

> > > OK. So now I have to say: _Don't_ use 2.4.20-rc* if you have a 
> > > aic7xxx. You can use 2.4.19 and maybe 2.4.20(?).
> > 
> > Just to clearify: _I don't_ have a aic7xxx!
> [ ... ]
> 
> Allright, got it. :-)
> 
> > Sunday evening I'll try rc3,
> 
> I'm not going to try it... I better wait on 2.4.21 stable release. :-)
> 
> > I'm looking forward to a freezing system again :-(
> 
> Have fun. :-)

Ok guys. I have quite the same problem, and I tested justins aic on top of
2.4.21-rc2. You can expect it to perform better. Without justins aic my box
froze every day, with it I just managed to freeze it first time after 14 days.
It looks better, but not solved. I am now out and trying rc3 with justins
driver (20030520).

Regards,
Stephan

