Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274278AbRI3Xr3>; Sun, 30 Sep 2001 19:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274285AbRI3XrT>; Sun, 30 Sep 2001 19:47:19 -0400
Received: from wisdn-0.gus.net ([208.146.196.17]:20485 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S274278AbRI3XrI>; Sun, 30 Sep 2001 19:47:08 -0400
Date: Sun, 30 Sep 2001 16:47:28 -0700 (PDT)
From: Jim Treadway <jim@stardot-tech.com>
To: Olaf Titz <olaf@bigred.inka.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Makefile gcc -o /dev/null: the dissapearing of /dev/null
In-Reply-To: <E15nhVx-00017F-00@bigred.inka.de>
Message-ID: <Pine.LNX.4.33.0109301642560.30207-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Sep 2001, Olaf Titz wrote:

> > So then you can no longer 'make modules && make modules_install', or you
> > have to cp or chown /usr/src/linux on a fresh install to compile your
> > kernel?   Doesn't sound pleasant to me.
>
> I just do "MakeDist -a" as user and untar the result as root. Script
> appended.

[SNIPPED]

Thanks :) but my "complaint" was really that it was suggested that
compiling the kernel (or rather, evaluating certain Makefile variables)
as root was akin to crossing a busy freeway blindfolded or something.

This all goes back to a disappearing "/dev/null" which apparently may have
been an isolated incident.


Jim

