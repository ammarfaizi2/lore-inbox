Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbSLWUiU>; Mon, 23 Dec 2002 15:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266972AbSLWUiU>; Mon, 23 Dec 2002 15:38:20 -0500
Received: from 4-090.ctame701-1.telepar.net.br ([200.193.162.90]:64935 "EHLO
	4-090.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S266971AbSLWUiT>; Mon, 23 Dec 2002 15:38:19 -0500
Date: Mon, 23 Dec 2002 18:46:11 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: User & <breno_silva@beta.bandnet.com.br>
cc: linux-kernel@vger.kernel.org
Subject: RE: PAGE = 1k
In-Reply-To: <20021223165245.M26209@beta.bandnet.com.br>
Message-ID: <Pine.LNX.4.50L.0212231845340.26879-100000@imladris.surriel.com>
References: <20021223165245.M26209@beta.bandnet.com.br>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2002, User & wrote:

> yes i know ,it´s depend of hardware, but maybe we can do something as mmu
> with software or something like this , i don´t know.

No, the software cannot patch the hardware.

The MMU does address translations in 4 kB blocks and there's
nothing you can do about that.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
