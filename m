Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSIENSZ>; Thu, 5 Sep 2002 09:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSIENSZ>; Thu, 5 Sep 2002 09:18:25 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:17594 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S317488AbSIENSY>; Thu, 5 Sep 2002 09:18:24 -0400
Date: Thu, 5 Sep 2002 10:22:49 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: shakira banu <shak_banu@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Attention to Scheduler Workers!!!
In-Reply-To: <20020905043227.63466.qmail@web20009.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44L.0209051021120.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2002, shakira banu wrote:

>  robin.we plan to change to shortest remaining time
>  first.this is our proposa.

>  could u please give ur valuable suggestions reg. the
> project?

Well, first you'll need a subsystem to look into the
future, so you know how much remaining time each
process has.

Once you can look into the future, you can simply sort
the tasks by remaining time and run them in order.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

