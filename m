Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318562AbSIFMvw>; Fri, 6 Sep 2002 08:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318572AbSIFMvw>; Fri, 6 Sep 2002 08:51:52 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2251 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318562AbSIFMvv>; Fri, 6 Sep 2002 08:51:51 -0400
Date: Fri, 6 Sep 2002 14:56:25 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andreas Steinmetz <ast@domdv.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20pre5 trivial compiler warning fix for irtty.c
In-Reply-To: <3D77C532.3050806@domdv.de>
Message-ID: <Pine.NEB.4.44.0209061452550.7218-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Andreas Steinmetz wrote:

> the attached patch fixes deprecated usage warnings for __FUNCTION__ in
> irtty.c.

Hi Andreas,

a similar patch is already in -ac. It's perhaps the best if you make such
patches against -ac because -ac contains several smaller cleanups and
fixes that aren't yet in 2.4.20pre.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


