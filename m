Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278915AbRJVVBu>; Mon, 22 Oct 2001 17:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278917AbRJVVBl>; Mon, 22 Oct 2001 17:01:41 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49426 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S278915AbRJVVB0>; Mon, 22 Oct 2001 17:01:26 -0400
Date: Mon, 22 Oct 2001 17:40:47 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Peter Hamilton <lobsterphoneuk@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.12: High disk activity + system load causes lockup.
In-Reply-To: <20011022215712.A763@hamil.org>
Message-ID: <Pine.LNX.4.21.0110221740230.16025-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Oct 2001, Peter Hamilton wrote:

> 2.4.12: High disk activity + system load causes lockup.
> 
> The first time this happened, I was copying .wav files from a vfat
> partition (about 30..80Mb each).  The second time I was running lame
> whilst downloading news.  I found the problem can be reliably reproduced
> by simply copying large files around (copy two lots at the same time
> and the system dies within 10..30 seconds).  Nothing is printed to
> the console or written to any log files, and the only way to recover
> is to hit the reset button.
> The system seems stable in every other respect.
> 
> I've moved back to 2.4.6 which is fine.  Also tried downloading
> a new 2.4.12 and configuring from scratch.
> 
> I'm not subscribed to this list, so please Cc: if you want me to
> see replies.

Pete, 

Please try to reproduce the problem without the Nvidia driver loaded.

Thanks.

