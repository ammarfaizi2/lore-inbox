Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319525AbSIGViV>; Sat, 7 Sep 2002 17:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319528AbSIGViV>; Sat, 7 Sep 2002 17:38:21 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60146 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S319525AbSIGViU>; Sat, 7 Sep 2002 17:38:20 -0400
Date: Sat, 7 Sep 2002 23:42:54 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Hans-Peter Jansen <hpj@urpla.net>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre5-ac4
In-Reply-To: <200209072328.27543.hpj@urpla.net>
Message-ID: <Pine.NEB.4.44.0209072340190.7218-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Sep 2002, Hans-Peter Jansen wrote:

> Hi Alan, Andre, and friends,

Hi Hans-Peter,

>...
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[ide_build_sglist+73/384]    Tainted: PF
>...
> Anything missing? Just ask. 18-pre4 does that mount smoothly. Besides this glitch,
> 20-pre5-ac4 "feels" a bit more interactively responsive..

which non-free modues (NVidia?) were loaded on your computer? Is the
problem reproducible without any non-free module loaded _ever_ since the
last reboot? If it's still reproducible then please run the output through
ksymoops as described in Documentation/oops-tracing.txt.

> Hans-Peter

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox




