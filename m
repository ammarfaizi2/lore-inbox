Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSG1OKM>; Sun, 28 Jul 2002 10:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSG1OKM>; Sun, 28 Jul 2002 10:10:12 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:57861 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316500AbSG1OKL>; Sun, 28 Jul 2002 10:10:11 -0400
Date: Sun, 28 Jul 2002 11:11:57 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ville Herva <vherva@niksula.hut.fi>
cc: Buddy Lumpkin <b.lumpkin@attbi.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About the need of a swap area
In-Reply-To: <20020728065830.GT1465@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.44L.0207281111350.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002, Ville Herva wrote:

> If you have swap, it makes sense to use it. What doesn't make
> sense is to waste time waiting for paging to happen.

Unless of course you're running on battery power...

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

