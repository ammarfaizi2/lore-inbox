Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318591AbSHPRJr>; Fri, 16 Aug 2002 13:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318601AbSHPRJr>; Fri, 16 Aug 2002 13:09:47 -0400
Received: from mallaury.noc.nerim.net ([62.4.17.82]:5641 "HELO
	mallaury.noc.nerim.net") by vger.kernel.org with SMTP
	id <S318591AbSHPRJq>; Fri, 16 Aug 2002 13:09:46 -0400
Date: Fri, 16 Aug 2002 19:15:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: ben@beroul.uklinux.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 ATAPI cdrom I/O errors when reading CD-R
Message-Id: <20020816191508.5f9589b4.khali@linux-fr.org>
In-Reply-To: <Pine.NEB.4.44.0208161410330.6334-100000@mimas.fachschaften.tu-muenchen.de>
References: <20020816094819.160d5e33.khali@linux-fr.org>
	<Pine.NEB.4.44.0208161410330.6334-100000@mimas.fachschaften.tu-muenchen.de>
Organization: http://www.linux-fr.org/
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Could you please try to read the same CD-R with kernel 2.4.18? If
> > you still can't read the CD, try with kernel 2.4.17, and so on back
> > to 2.2.20, so we have a chance to find the change causing the
> > problem. (Be careful to skip problematic kernels, 2.4.15 and 2.4.11
> > come to mind.)
> 
> This is a joke, isn't it?

Hm no, wasn't. I couldn't see another solution. Seems a bit hard to
reproduce on another system, since it must be related to the specific
hardware (drive, writer and CD-R) used.

What would you suggest?

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
