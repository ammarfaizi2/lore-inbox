Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272287AbTGYUPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272288AbTGYUPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:15:51 -0400
Received: from math.ut.ee ([193.40.5.125]:48884 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S272287AbTGYUPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:15:50 -0400
Date: Fri, 25 Jul 2003 23:30:49 +0300 (EEST)
From: Meelis Roos <mroos@math.ut.ee>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, <neilb@cse.unsw.edu.au>
Subject: Re: NFS server broken in 2.4.22-pre6?
In-Reply-To: <Pine.LNX.4.55L.0307251001480.12492@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.44.0307252330160.23197-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > NFS serving seems to be broken in 2.4.22-pre6. I had 2 computers running
> > 2.4.22-pre6 (x86, debian unstable current). Tried to acces them via NFS
> > (using am-utils actually) from a 3rd computer, IO error. Tried to
> > mount directly, mount: RPC: timed out. Rebooted one computer to 2.4.18
> > and NFS started to work.
> >
> > No more details currently but I can test more thoroughly tomorrow.
>
> Meelis,
>
> Please report more details.

Seems to be a debian unstable problem with nfs-kernel-server:
http://bugs.debian.org/201598

-- 
Meelis Roos             e-mail: mroos@ut.ee
                        www:    http://www.cs.ut.ee/~mroos/

