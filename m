Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318265AbSHDV3c>; Sun, 4 Aug 2002 17:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSHDV3c>; Sun, 4 Aug 2002 17:29:32 -0400
Received: from pD9E2319C.dip.t-dialin.net ([217.226.49.156]:37068 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318265AbSHDV3b>; Sun, 4 Aug 2002 17:29:31 -0400
Date: Sun, 4 Aug 2002 15:32:59 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Nico Schottelius <nico-mutt@schottelius.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: floppy issue also in 2.4.18 ?  / 2.5 solution
In-Reply-To: <20020804053705.GA9854@schottelius.org>
Message-ID: <Pine.LNX.4.44.0208041529520.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 4 Aug 2002, Nico Schottelius wrote:
> 1) Why does 2.4.18 kernel hangs when I try to boot it from floppy ?
>    Symptoms: After 'Loading ... ' progress finished, the disk drive's
>    led is still lighting and nothing happens anymore.
>    What can be wrong ? CPU is correct (I even tried 386,586,p-classic,p-mmx,..),
>    it's a P133. And howto fix it?

Yo. Some days ago there was a patch that fixed the floppy I/O driver. I'll 
append it, against 2.5.29.

> 2) Somebody explain me what changed in vfs, where to find doc and give me some
>    time to fix that damn 2.5 floppy driver. I'm gonna fight it.

It was in 2.5.12. Just look at the changes, I don't have a pointer right 
now. (I'm busy writing something about the downturn of the first ancient 
egypt empire...)

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

