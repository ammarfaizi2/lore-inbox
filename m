Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSELLTt>; Sun, 12 May 2002 07:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSELLTs>; Sun, 12 May 2002 07:19:48 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:53584 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S312558AbSELLTs>; Sun, 12 May 2002 07:19:48 -0400
Date: Sun, 12 May 2002 05:19:41 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linus' BK repository out of date? Moved?
Message-ID: <Pine.LNX.4.44.0205120512440.4369-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For several days now whenever I try to pull from 
http://linux.bkbits.net/linux-2.5 or ~1/linux-2.4, I get no news. Even if 
I clone to a new tree, check out and do a diff to the old tree, I get no 
changes. version.h says:

#define UTS_RELEASE "2.5.14"
#define LINUX_VERSION_CODE 132366

Did the tree move, or what's up?

						        Regards,
							Thunder
-- 
if (errno == ENOTAVAIL)
    fprintf(stderr, "Error: Talking to Microsoft server!\n");

