Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSG1T0g>; Sun, 28 Jul 2002 15:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSG1T0g>; Sun, 28 Jul 2002 15:26:36 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:776 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317081AbSG1T0f>; Sun, 28 Jul 2002 15:26:35 -0400
Date: Sun, 28 Jul 2002 16:29:29 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ed Sweetman <safemode@speakeasy.net>
cc: Buddy Lumpkin <b.lumpkin@attbi.com>, Ville Herva <vherva@niksula.hut.fi>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: About the need of a swap area
In-Reply-To: <1027882706.4228.138.camel@psuedomode>
Message-ID: <Pine.LNX.4.44L.0207281629010.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jul 2002, Ed Sweetman wrote:

> If you bother to do any real tests you'd see that linux will swap when
> nothing is going on and this doesn't hinder anything.

Linux only puts pages in swap when it's low on free physical memory.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

