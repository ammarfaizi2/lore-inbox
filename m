Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262626AbREZXDJ>; Sat, 26 May 2001 19:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbREZXBl>; Sat, 26 May 2001 19:01:41 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262590AbREZXAa>;
	Sat, 26 May 2001 19:00:30 -0400
Message-Id: <200105261349.f4QDnVx00377@hal.astr.lu.lv>
Content-Type: text/plain; charset=US-ASCII
From: Andris Pavenis <pavenis@latnet.lv>
To: Danny ter Haar <dth@trinity.hoho.nl>
Subject: Re: 2.4.4-ac[356]: network (8139too) related crashes
Date: Sat, 26 May 2001 16:49:31 +0300
X-Mailer: KMail [version 1.2.1]
In-Reply-To: <cistron.200105091321.f49DLbp06900@hal.astr.lu.lv> <E14xZaU-0000x5-00@trinity.hoho.nl>
In-Reply-To: <E14xZaU-0000x5-00@trinity.hoho.nl>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 May 2001 22:25, Danny ter Haar wrote:
> Andris Pavenis  <pavenis@latnet.lv> wrote:
> >With kernels 2.4.4-ac[356] I'm getting system freezing on FTP transfer
> > after some time. I'm trying to upload about 6.5Mb file using MC (transfer
> > speed about 300-1000Kb/s). With these kernel versions I'm getting random
> > total freezing system (no any kernel error messages, no reaction to
> > keyboard, no response to ping from other machine). The same seems to
> > happen also when transfer speed is slower (I left wget downloading many
> > files 2 nights and both times system was hanged in morning)
>
> I have similar problems on my sony vaio laptop (pcmcia ethernet
> card that works with the 8139too driver)
> I send detailed info to Jeff & Alan weeks ago.
>
> >Kernel 2.4.3-ac3 seems to be Ok.
>
> Problems started with the change in 2.4.3-ac7.
> So up to 2.4.3-ac6 it's fine.
>

Tried 2.4.5 and got the same problem again. Parhaps I'll sty with 2.4.3-ac3 
for now. At least it doesn't freeze ...

Andris
