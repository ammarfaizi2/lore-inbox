Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSEEPH7>; Sun, 5 May 2002 11:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313014AbSEEPH6>; Sun, 5 May 2002 11:07:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:22223 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312938AbSEEPH6>; Sun, 5 May 2002 11:07:58 -0400
Date: Sun, 5 May 2002 17:03:20 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Danijel Schiavuzzi <dschiavu@public.srce.hr>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel patching 2.4.19pre1 -> 2.4.19pre2
In-Reply-To: <200205051454.g45EsM89006510@jagor.srce.hr>
Message-ID: <Pine.NEB.4.44.0205051701330.283-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2002, Danijel Schiavuzzi wrote:

> Hi.

Hi Danijel,

> I'm trying to patch a 2.4.17 clean source tree to the latest 2.4.19-pre8 tree.
> I can patch it until the 2.4.19pre1.
> When I try to apply patch-2.4.19pre2.bz2, this happens:
>...
> Where's the problem?
>...

the 2.4.19pre patches are all against 2.4.18, IOW:
pre2 contains everything that is in pre1, too.

You should apply the 2.4.19pre8 patch directly to the 2.4.18 kernel
sources.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

