Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272286AbTGYUNB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272287AbTGYUNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:13:01 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30096 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S272286AbTGYUM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:12:59 -0400
Date: Fri, 25 Jul 2003 17:24:27 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Pavel Machek <pavel@suse.cz>
Cc: jimis@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related)
In-Reply-To: <20030723114322.GD729@zaurus.ucw.cz>
Message-ID: <Pine.LNX.4.55L.0307251723520.16728@freak.distro.conectiva>
References: <3F1E6A25.5030308@gmx.net> <20030723114322.GD729@zaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 Jul 2003, Pavel Machek wrote:

> Hi!
>
> > With the current scheduler we can prioritize the CPU usage for each
> > process. What I think would be extremely useful (as I have needed it
> > many times) is the scheduling of disk I/O and net I/O traffic. 2
> > examples showing the importance (the numbers are estimations just to
> > explain whati I mean):
>
> Yes that would be nice, and in 2.5 timeframe
> there was patch doing that. Port it to 2.6 an test it!

Pavel,

Do you remember who wrote those or where one can find it?
