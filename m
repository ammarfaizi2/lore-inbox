Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTE2Oqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbTE2Oqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:46:54 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9430
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262271AbTE2Oqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:46:52 -0400
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <20030529114001.GD7217@louise.pinerecords.com>
References: <20030529114001.GD7217@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054216894.20167.76.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 May 2003 15:01:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-29 at 12:40, Tomas Szepe wrote:
> o  2.4.21-rc6
> 	intrerrupt timeouts, can't r/w from/to drive reliably in pio, dma hosed
> 
> o  2.4.21-rc2-ac3
> 	r/w in pio ok, dma hosed
> 
> o  2.4.20
> 	intrerrupt timeouts, can't r/w from/to drive reliably in pio, dma hosed

The driver basically hasnt changed throughout these. Are you sure you
don't just have a bust Proliant - anyone else runnign 2.4.21-rc on a
proliant ?

