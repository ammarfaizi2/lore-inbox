Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317666AbSFRXEO>; Tue, 18 Jun 2002 19:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317665AbSFRXEO>; Tue, 18 Jun 2002 19:04:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15621 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317664AbSFRXEN>; Tue, 18 Jun 2002 19:04:13 -0400
Date: Tue, 18 Jun 2002 19:08:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: richard.brunner@amd.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: Cache-attribute conflict bug in the kernel exposed on newer A
 MD Athlon CPUs
In-Reply-To: <39073472CFF4D111A5AB00805F9FE4B609BA672A@txexmta9.amd.com>
Message-ID: <Pine.LNX.4.44.0206181908040.5120-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'll wait for your confirmation so this patch can go in -rc1.

On Tue, 18 Jun 2002 richard.brunner@amd.com wrote:

> There were some issues with uniprocessor APIC
> in the "short-term" patch. Many thanks to Bryan O'Sullivan
> for pointing it out and generating the fixed patch.
>
> We are testing it right now. But, so far
> things look OK and the change is pretty simple.


