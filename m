Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131227AbRCNAOd>; Tue, 13 Mar 2001 19:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131238AbRCNAOX>; Tue, 13 Mar 2001 19:14:23 -0500
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:18170
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S131227AbRCNAOJ>; Tue, 13 Mar 2001 19:14:09 -0500
Date: Wed, 14 Mar 2001 01:13:21 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@mimas.fachschaften.tu-muenchen.de>
To: James Stevenson <mistral@stev.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM problem with 2.2.18 ?
In-Reply-To: <Pine.LNX.4.21.0103132323450.18168-100000@cyrix.home>
Message-ID: <Pine.NEB.4.33.0103140112121.8693-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2001, James Stevenson wrote:

> Hi
>
> i had a small problem with a program i was running
> which got stuck in a loop allocing memory by the time i
> found out it was doing it these were appearing
>
>  VM: do_try_to_free_pages failed for ypbind...
>  VM: do_try_to_free_pages failed for syslogd...
>...

This is a known bug in 2.2.18 that is fixed in the 2.2.19preX kernels
since 2.2.19pre2 .

> thanks
> 	James

cu
Adrian

-- 

Nicht weil die Dinge schwierig sind wagen wir sie nicht,
sondern weil wir sie nicht wagen sind sie schwierig.

