Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSJLSFT>; Sat, 12 Oct 2002 14:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbSJLSFT>; Sat, 12 Oct 2002 14:05:19 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:59835 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261356AbSJLSFS>; Sat, 12 Oct 2002 14:05:18 -0400
Date: Sat, 12 Oct 2002 15:10:48 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: jw schultz <jw@pegasys.ws>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.42
In-Reply-To: <20021012111140.GA22536@pegasys.ws>
Message-ID: <Pine.LNX.4.44L.0210121510110.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002, jw schultz wrote:

> So far everything indicates that LVM2 is not compatible with
> LVM.

On the contrary.  Everything I've seen indicates that device
mapper is compatible with anything and just needs userland
helpers to set up the mapping.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

