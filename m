Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTFTVCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTFTVCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:02:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6111 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263738AbTFTVCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:02:24 -0400
Date: Fri, 20 Jun 2003 18:13:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, stoffel@lucent.com,
       gibbs@scsiguy.com, linux-kernel@vger.kernel.org, willy@w.ods.org,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <3EF375BA.80901@cox.net>
Message-ID: <Pine.LNX.4.55L.0306201812190.3808@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
 <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com>
 <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com>
 <41560000.1055306361@caspian.scsiguy.com> <20030611222346.0a26729e.skraw@ithnet.com>
 <16103.39056.810025.975744@gargle.gargle.HOWL> <20030613114531.2b7235e7.skraw@ithnet.com>
 <Pine.LNX.4.55L.0306171744280.10802@freak.distro.conectiva>
 <20030618130533.1f2d7205.skraw@ithnet.com> <Pine.LNX.4.55L.0306201658210.2607@freak.distro.conectiva>
 <3EF375BA.80901@cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jun 2003, Kevin P. Fleming wrote:

> Marcelo Tosatti wrote:
>
> > So the data is intact when it arrives on the 3ware and gets corrupted
> > on the write to the tape?
> >
>
> Actually, without another copy of the data on a different system to
> verify it with, you can't know that for sure. It could easily be getting
> to the tape (the actual media) just fine, but then get corrupted during
> the verify readback.

Right. Stephan, if you could use a bit of your time to isolate the problem
I would be VERY grateful.

