Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318102AbSGMGDX>; Sat, 13 Jul 2002 02:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318105AbSGMGDW>; Sat, 13 Jul 2002 02:03:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:46328 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318102AbSGMGDV>; Sat, 13 Jul 2002 02:03:21 -0400
Date: Sat, 13 Jul 2002 08:06:08 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Urban Widmark <urban@teststation.com>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>,
       "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Subject: Re: What is the most stable kernel to date?
In-Reply-To: <Pine.LNX.4.44.0207130009110.7728-100000@cola.enlightnet.local>
Message-ID: <Pine.NEB.4.44.0207130801370.24665-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2002, Urban Widmark wrote:

> > Perhaps in your "normal use"...
> >
> > If you mount SMB shares Oopses appear quite frequently.
>
> 2.4.18 oopses if the share has characters that are not in your nls table.
> Patched and fixed for 2.4.19 (unless you are talking about some other oops?)

The Oopses I saw on my machine were fixed by
00-smbfs-2.4.18-codepage.patch. I saw an Oops by someone else that wasn't
fixed by this patch but it seems it was fixed by something else in
2.4.19-pre.

> /Urban

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

