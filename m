Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbTE2PLg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbTE2PLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:11:35 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:64711 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262294AbTE2PLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:11:34 -0400
Date: Thu, 29 May 2003 17:24:44 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
Message-ID: <20030529152444.GL7217@louise.pinerecords.com>
References: <20030529114001.GD7217@louise.pinerecords.com> <1054216894.20167.76.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054216894.20167.76.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> On Iau, 2003-05-29 at 12:40, Tomas Szepe wrote:
> > o  2.4.21-rc6
> > 	intrerrupt timeouts, can't r/w from/to drive reliably in pio, dma hosed
> > 
> > o  2.4.21-rc2-ac3
> > 	r/w in pio ok, dma hosed
> > 
> > o  2.4.20
> > 	intrerrupt timeouts, can't r/w from/to drive reliably in pio, dma hosed
> 
> The driver basically hasnt changed throughout these. Are you sure you
> don't just have a bust Proliant - anyone else runnign 2.4.21-rc on a
> proliant?

No, I can't be sure.

Basically I posted the report just in case somebody finds it useful,
for production use I'm sticking in an add-on cmd64x-based controller.

Thanks, Alan.

-- 
Tomas Szepe <szepe@pinerecords.com>
