Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTFIUNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTFIUNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:13:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20185 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261222AbTFIUNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:13:38 -0400
Date: Mon, 9 Jun 2003 17:24:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, support@comtrol.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] License issue with rocket driver
In-Reply-To: <1054912734.17185.3.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0306091724260.26529@freak.distro.conectiva>
References: <20030606094759.GA20229@lst.de> <1054912734.17185.3.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Jun 2003, Alan Cox wrote:

> On Gwe, 2003-06-06 at 10:47, Christoph Hellwig wrote:
> > drivers/char/rocket{,_int}.h have an intereesting and gpl-incompatible
> > license.  Could you please fix it or remove the drier from the tree?
> > (given that mess that this driver is the latter might be the better
> > idea..)
>
> Ditto for 2.4 it appears. Marcelo can you rm the comtrol driver pending
> clarification. I'll do the same for 2.2, and Linus needs to pull it for
> 2.5

I'm going to do that now in case there is no other fix.

Any answer from the Rocket driver people ?
