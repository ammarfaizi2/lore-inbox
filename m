Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbTF3L1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 07:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265846AbTF3L1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 07:27:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:11702 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265845AbTF3L1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 07:27:41 -0400
Date: Mon, 30 Jun 2003 08:39:38 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, stoffel@lucent.com, willy@w.ods.org,
       kpfleming@cox.net, gibbs@scsiguy.com, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030630121017.1ebc1cf4.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.55L.0306300838200.19541@freak.distro.conectiva>
References: <20030509150207.3ff9cd64.skraw@ithnet.com>
 <41560000.1055306361@caspian.scsiguy.com> <20030611222346.0a26729e.skraw@ithnet.com>
 <16103.39056.810025.975744@gargle.gargle.HOWL> <20030613114531.2b7235e7.skraw@ithnet.com>
 <20030625191655.GA15970@alpha.home.local> <20030625214221.2cd9613f.skraw@ithnet.com>
 <16122.1630.134766.108510@gargle.gargle.HOWL> <20030626133415.4417e2e6.skraw@ithnet.com>
 <20030630121017.1ebc1cf4.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Jun 2003, Stephan von Krawczynski wrote:

> Hello all,
>
> it looks like the problem gets worse currently. This is the second day I see 4
> verification errors. This is with kernel 2.4.22-pre2 now.


As far as I understood, the tape is corrupting the data (or writting, or
when reading back).

Is this correct?
