Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319417AbSILCpp>; Wed, 11 Sep 2002 22:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319418AbSILCpp>; Wed, 11 Sep 2002 22:45:45 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:62952 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319417AbSILCpo>; Wed, 11 Sep 2002 22:45:44 -0400
Date: Wed, 11 Sep 2002 23:50:19 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: Rick Lindsley <ricklind@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
In-Reply-To: <3D7FFF12.24B0FDAA@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209112350000.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2002, Andrew Morton wrote:

> My vote: remove the disk accounting from kernel_stat and use this.

Whatever you decide on, I'll fix up procps to support it.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

