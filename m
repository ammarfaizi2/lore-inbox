Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265810AbRHJIQa>; Fri, 10 Aug 2001 04:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbRHJIQU>; Fri, 10 Aug 2001 04:16:20 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20498 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265810AbRHJIQF>; Fri, 10 Aug 2001 04:16:05 -0400
Date: Fri, 10 Aug 2001 03:46:39 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Eduard Phetisov <wert@mb.ru>
Cc: linux-kernel@vger.kernel.org, haible@ma2s2.mathematik.uni-karlsruhe.de,
        osrc@pell.chi.il.us, quintela@fi.udc.es, dwmw2@redhat.com
Subject: Re: BUG in the kernels 2.4.x
In-Reply-To: <3B739598.BC4091DB@mb.ru>
Message-ID: <Pine.LNX.4.21.0108100346200.15623-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Aug 2001, Eduard Phetisov wrote:

> I think what I find a bug in the kernels 2.4.x.
> Bug apears then several processes allocates some memory. If size of the
> free memory less then size of claimed memory by processes, system went
> down. 

What do you mean by system went down ?

Complete lockup or slowndown?

