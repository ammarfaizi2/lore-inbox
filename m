Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269619AbRHCVZT>; Fri, 3 Aug 2001 17:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269620AbRHCVY7>; Fri, 3 Aug 2001 17:24:59 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:47634 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269619AbRHCVYr>;
	Fri, 3 Aug 2001 17:24:47 -0400
Date: Fri, 3 Aug 2001 18:24:53 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <3B6AD039.5060809@fugmann.dhs.org>
Message-ID: <Pine.LNX.4.33L.0108031823380.11893-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Anders Peter Fugmann wrote:

> I dont know task states are defined, but by 'running' I mean that it
> is not stopped by the VM, when the VM needs to fetch memory for the
> process.

What do you propose the program does when it doesn't have
its data ? Better give up the CPU for somebody else than
twiddle your thumbs while you don't have the data you want.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

