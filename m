Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSLBMpi>; Mon, 2 Dec 2002 07:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSLBMph>; Mon, 2 Dec 2002 07:45:37 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:59792 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262821AbSLBMph>; Mon, 2 Dec 2002 07:45:37 -0500
Date: Mon, 2 Dec 2002 10:52:54 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Santhosh Kumar <linuxkern@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Interrupting __free_pages_OK results in OOPS
In-Reply-To: <20021202070501.27876.qmail@web14610.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44L.0212021052230.15981-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Santhosh Kumar wrote:

> My device driver has an interrupt handler which
> handles interrupts at a very high priority. Sometimes
> the interrupt handler OOPS in __free_pages_OK. Any
> idea why it happens.

> OOPS happens as follows.

Could you please give us the full oops output, decoded with
ksymoops ?

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

