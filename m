Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272051AbTGYMyD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 08:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272052AbTGYMyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 08:54:03 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55702 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S272051AbTGYMyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 08:54:00 -0400
Date: Fri, 25 Jul 2003 10:05:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Meelis Roos <mroos@math.ut.ee>
Cc: lkml <linux-kernel@vger.kernel.org>, neilb@cse.unsw.edu.au
Subject: Re: NFS server broken in 2.4.22-pre6?
In-Reply-To: <Pine.GSO.4.44.0307242023530.5806-100000@math.ut.ee>
Message-ID: <Pine.LNX.4.55L.0307251001480.12492@freak.distro.conectiva>
References: <Pine.GSO.4.44.0307242023530.5806-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Jul 2003, Meelis Roos wrote:

> NFS serving seems to be broken in 2.4.22-pre6. I had 2 computers running
> 2.4.22-pre6 (x86, debian unstable current). Tried to acces them via NFS
> (using am-utils actually) from a 3rd computer, IO error. Tried to
> mount directly, mount: RPC: timed out. Rebooted one computer to 2.4.18
> and NFS started to work.
>
> No more details currently but I can test more thoroughly tomorrow.

Meelis,

Please report more details.
