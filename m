Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSGZFKZ>; Fri, 26 Jul 2002 01:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316845AbSGZFKY>; Fri, 26 Jul 2002 01:10:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:34514 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316842AbSGZFKY>; Fri, 26 Jul 2002 01:10:24 -0400
Date: Fri, 26 Jul 2002 07:13:36 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Anton Altaparmakov <aia21@cantab.net>
cc: linux-kernel@vger.kernel.org
Subject: RE: 2.5.28 and partitions
In-Reply-To: <5.1.0.14.2.20020725144011.00ab3ec0@pop.cus.cam.ac.uk>
Message-ID: <Pine.NEB.4.44.0207260709130.15439-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002, Anton Altaparmakov wrote:

> At 14:24 25/07/02, Petr Vandrovec wrote:
> >But I care whether gcc barfs on code or not, and whether generated code
> >is correct or not.
>
> Everyone cares about that! That has nothing to do with performance. It's
> simply a broken compiler which needs fixing.
>...

Unfortunately the 2.95 branch of gcc is more or less dead: Noone maintains
it and no new release is planned. It's perhaps a more useful work to get
the kernel compiling with gcc 3.1/3.2 ...

> Best regards,
>
>          Anton

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


