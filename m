Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289573AbSBEPG0>; Tue, 5 Feb 2002 10:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289577AbSBEPGQ>; Tue, 5 Feb 2002 10:06:16 -0500
Received: from mustard.heime.net ([194.234.65.222]:37795 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S289573AbSBEPGF>; Tue, 5 Feb 2002 10:06:05 -0500
Date: Tue, 5 Feb 2002 16:05:59 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: "Drew P. Vogel" <dvogel@intercarve.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: opening a bzImage?
In-Reply-To: <Pine.LNX.4.33.0202050950030.20253-100000@northface.intercarve.net>
Message-ID: <Pine.LNX.4.30.0202051605390.13494-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've never tried this, but could you do something like
>
> bunzip2 -c bzImage > zImage && ar -t zImage

Doesn't work

bzcat: dist/images/kernel-nfs is not a bzip2 file.


--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

