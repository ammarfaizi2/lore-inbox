Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267220AbSKUX6r>; Thu, 21 Nov 2002 18:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbSKUX6r>; Thu, 21 Nov 2002 18:58:47 -0500
Received: from 1-245.ctame701-1.telepar.net.br ([200.181.137.245]:12454 "EHLO
	1-245.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267220AbSKUX6p>; Thu, 21 Nov 2002 18:58:45 -0500
Date: Thu, 21 Nov 2002 22:05:43 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Max Valdez <maxvaldez@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Too muxh paging with 2.4.20-rc2-ac1
In-Reply-To: <1037891119.7845.18.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L.0211212204270.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Nov 2002, Alan Cox wrote:

> The latest -ac has Rik's newer rmap code. It seems to have a few
> problems so I may back it out again soon until Rik figures out the
> problem

There are no functional changes in the batch of small patches
I sent you last week.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

