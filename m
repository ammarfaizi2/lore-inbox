Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264958AbRGIVSh>; Mon, 9 Jul 2001 17:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264959AbRGIVS1>; Mon, 9 Jul 2001 17:18:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:15627 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264958AbRGIVSN>;
	Mon, 9 Jul 2001 17:18:13 -0400
Date: Mon, 9 Jul 2001 18:18:08 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Adam Shand <larry@spack.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
In-Reply-To: <Pine.LNX.4.32.0107091250170.25061-100000@maus.spack.org>
Message-ID: <Pine.LNX.4.33L.0107091816500.24217-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2001, Adam Shand wrote:

>  * What is the maximum amount of RAM that a *single* process can address
>    under a 2.4 kernel, with PAE enabled?  Without?

3 GB, 3GB.  This is basically a hardware limit.

>  * And, what (if any) paramaters can effect this (recompiling the app
>    etc)?

Alpha, AMD Hammer, ...  ;)


regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

