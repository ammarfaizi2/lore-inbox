Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266552AbSL2McS>; Sun, 29 Dec 2002 07:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266555AbSL2McS>; Sun, 29 Dec 2002 07:32:18 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:14512 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S266552AbSL2McR>; Sun, 29 Dec 2002 07:32:17 -0500
Date: Sun, 29 Dec 2002 10:40:19 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Martijn Sipkema <m.j.w.sipkema@student.tudelft.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: TimeSys violating GPL?
In-Reply-To: <000d01c2af33$97825850$161b14ac@boromir>
Message-ID: <Pine.LNX.4.50L.0212291039180.26879-100000@imladris.surriel.com>
References: <000d01c2af33$97825850$161b14ac@boromir>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Dec 2002, Martijn Sipkema wrote:

> Is TimeSys (http://www.timesys.com) violating the GPL by extending
> Linux with new features (high resolution clocks and timers, protection
> against priority inversion) by adding a proprietary loadable kernel module?

If their module is a derivative of GPL code, then yes.

If the total work consisting of GPL code and their
proprietary module is a derivative of GPL code, then
probably.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
