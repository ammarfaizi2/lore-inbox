Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRCRXuA>; Sun, 18 Mar 2001 18:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131309AbRCRXtu>; Sun, 18 Mar 2001 18:49:50 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:10762 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131307AbRCRXte>; Sun, 18 Mar 2001 18:49:34 -0500
Date: Sun, 18 Mar 2001 19:03:28 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guillaume Cottenceau <gc@mandrakesoft.com>
Subject: Re: Q: "kapm-idled" and CPU usage
In-Reply-To: <3AB50177.47489C00@mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0103181902420.13050-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Jeff Garzik wrote:

> Is there some way to hack the scheduler statistics so that idle
> processes are special cases, which do not accumulate CPU time nor
> contribute to the load average?

It's trivial. I remember seeing a patch that does exactly this
on linux-kernel, probably around the time kapmd was renamed.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

