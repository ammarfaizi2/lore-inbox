Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262232AbSJEIUj>; Sat, 5 Oct 2002 04:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262233AbSJEIUi>; Sat, 5 Oct 2002 04:20:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36584 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262232AbSJEIUh>; Sat, 5 Oct 2002 04:20:37 -0400
Date: Sat, 5 Oct 2002 10:26:08 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: sean darcy <seandarcy@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40 compile fails: undef ref in drivers/builtin.o
In-Reply-To: <F139LiemHEBX9Bh57850000f9ad@hotmail.com>
Message-ID: <Pine.NEB.4.44.0210051025490.17935-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002, sean darcy wrote:

>...
> --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o
> arch/i386/mach-generic/built-in.o kernel/built-in.o mm/built-in.o
> fs/built-in.o ipc/built-in.o security/built-in.o  lib/lib.a
> arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o
> arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
> drivers/built-in.o(.data+0x2e174): undefined reference to `local symbols in
> discarded section .text.exit'
> make: *** [vmlinux] Error 1

Could you send your .config?

> jay

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

