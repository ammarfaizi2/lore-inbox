Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTE2Pj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTE2Pj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:39:59 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:2760 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262306AbTE2Pj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:39:58 -0400
Date: Thu, 29 May 2003 17:53:05 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
Message-ID: <20030529155305.GM7217@louise.pinerecords.com>
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
> proliant ?

Whoa, guess what -- 2.4.21-rc5-ac1 doesn't see the drive at all.

-- 
Tomas Szepe <szepe@pinerecords.com>
