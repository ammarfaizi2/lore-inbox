Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318159AbSHMPKG>; Tue, 13 Aug 2002 11:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSHMPKF>; Tue, 13 Aug 2002 11:10:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25579 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318159AbSHMPKD>; Tue, 13 Aug 2002 11:10:03 -0400
Date: Tue, 13 Aug 2002 17:13:50 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Lee Leahu <lee@ricis.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel crashes with 2.4.17
In-Reply-To: <20020813084358.7e8de7d3.lee@ricis.com>
Message-ID: <Pine.NEB.4.44.0208131711020.14606-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2002, Lee Leahu wrote:

> I am running the Linux Kernel 2.4.17.
>
> >From what I have put here, what can you tell might be the problem?
>...
> Aug 13 06:40:40 list kernel: Oops: 0000
>...

1. Please run this through ksymoops as described in
   Documentation/oops-tracing.txt in the kernel source tree.
2. There are _many_ bug fixes in 2.4.19 compared to 2.4.17, could you
   first try whether the problem still exists in 2.4.19?

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


