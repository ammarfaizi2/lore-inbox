Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264984AbTIJP17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264992AbTIJP17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:27:59 -0400
Received: from halon.barra.com ([144.203.11.1]:13789 "EHLO halon.barra.com")
	by vger.kernel.org with ESMTP id S264984AbTIJP14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:27:56 -0400
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: Jeff Garzik <jgarzik@pobox.com>, Sven-Haegar Koch <haegar@sdinet.de>
Subject: Re: [PATCH] Re: ifconfig up/down problem
Date: Wed, 10 Sep 2003 07:52:18 -0700
User-Agent: KMail/1.5.3
Cc: netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>,
       Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.56.0309090004100.24700@space.comunit.de> <200309091635.58748.fedor@karpelevitch.net> <200309092308.48099.fedor@karpelevitch.net>
In-Reply-To: <200309092308.48099.fedor@karpelevitch.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309100752.19594.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fedor Karpelevitch wrote:
> Fedor Karpelevitch wrote:
> > Jeff Garzik wrote:
> > > Sven-Haegar Koch wrote:
> > > > Kernel 2.4.20-pre2-ac3 is ok (my last kernel, running for
> > > > month')
> > >
> > > Does the attached patch fix it?
> > >
> > > 	Jeff
> >
> > does not help me (assuming I have the same problem). I have a
> > total lockup a few seconds after setting up the interface (not
> > immidiately).
> >
> > Fedor.
>
> actually it seemed to have helped with 2.6.0-test5 where I was
> apparently having the same issue. Not with 2.4.23-pre3 however...
>
> Fedor.

I am really sorry for giving all this misleading information but now 
it works fine for me with 2.4.23-pre3 as well, but I bet it did lock 
up the first time I tried it. So there may be something wrong with me 
or it is some other random problem I am seeing...

Fedor
