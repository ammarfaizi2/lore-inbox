Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315170AbSDWLng>; Tue, 23 Apr 2002 07:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315171AbSDWLnf>; Tue, 23 Apr 2002 07:43:35 -0400
Received: from mustard.heime.net ([194.234.65.222]:1423 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S315170AbSDWLnf>; Tue, 23 Apr 2002 07:43:35 -0400
Date: Tue, 23 Apr 2002 13:43:23 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_RAMFS in 2.4.19-pre7-ac2 ???
In-Reply-To: <aa1p5d$qki$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0204231341480.10981-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_RAMFS is probably going away, but that doesn't mean ramfs is
> going away.  At least in Linux 2.5 ramfs will end up being required
> core code.

According to what I was told by a guy at #KernelNewbies, CONFIG_RAMFS 
isn't there in (menu|x)?config after -pre7, but in by default. problem is 
- it doesn't work

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

