Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315456AbSEGXqD>; Tue, 7 May 2002 19:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSEGXqC>; Tue, 7 May 2002 19:46:02 -0400
Received: from pD952A78A.dip.t-dialin.net ([217.82.167.138]:29091 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315456AbSEGXqB>; Tue, 7 May 2002 19:46:01 -0400
Date: Tue, 7 May 2002 17:45:59 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HCIRESETSTAT, HCIGETINFO on sparc64, ppc64
In-Reply-To: <Pine.LNX.4.44.0205071703490.15559-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.LNX.4.44.0205071745230.19544-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> COMPATIBLE_IOCTL(HCIRESETSTAT)
> COMPATIBLE_IOCTL(HCIGETINFO)

Sorry, I didn't realize it was patched. The patch isn't yet in the tree...

Regards,
Thunder
--
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");

