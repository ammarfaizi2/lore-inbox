Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289781AbSAJXpG>; Thu, 10 Jan 2002 18:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289782AbSAJXo5>; Thu, 10 Jan 2002 18:44:57 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:36063 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S289781AbSAJXoq>; Thu, 10 Jan 2002 18:44:46 -0500
Date: Fri, 11 Jan 2002 00:44:30 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3
In-Reply-To: <Pine.LNX.4.21.0201101827100.22287-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0201110040420.13965-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

something changed between pre2 and pre3 that broke the booting of
non-modular kernels. After LILO's "Loading Linux" message nothing else
happens. When I enable CONFIG_MODULES my kernel boots.

cu
Adrian


