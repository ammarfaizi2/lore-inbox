Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286373AbRLJUDQ>; Mon, 10 Dec 2001 15:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286372AbRLJUDL>; Mon, 10 Dec 2001 15:03:11 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:34821 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286367AbRLJUCi>; Mon, 10 Dec 2001 15:02:38 -0500
Date: Mon, 10 Dec 2001 16:46:02 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Abraham vd Merwe <abraham@2d3d.co.za>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up
In-Reply-To: <20011210101452.F1502@crystal.2d3d.co.za>
Message-ID: <Pine.LNX.4.21.0112101645280.25362-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Abraham vd Merwe wrote:

> Hi!
> 
> If I leave my machine on for a day or two without doing anything on it (e.g.
> my machine at work over a weekend) and I come back then 1) all my memory is
> used for buffers/caches and when I try running application, the OOM killer
> kicks in, tries to allocate swap space (which I don't have) and kills
> whatever I try start (that's with 300M+ memory in buffers/caches).

Abraham, 

I'll take a look at this issue as soon as pre8 is released. 

