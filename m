Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262959AbTCKP6L>; Tue, 11 Mar 2003 10:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262960AbTCKP6L>; Tue, 11 Mar 2003 10:58:11 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:56275 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262959AbTCKP6K>;
	Tue, 11 Mar 2003 10:58:10 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200303111608.TAA13074@sex.inr.ac.ru>
Subject: Re: kernel panic: bug in sch_sfq.c
To: abz@frogfoot.net (Abraham van der Merwe)
Date: Tue, 11 Mar 2003 19:08:18 +0300 (MSK)
Cc: devik@cdi.cz, ahu@ds9a.nl, linux-kernel@vger.kernel.org,
       david@uninetwork.co.za, netdev@oss.sgi.com
In-Reply-To: <20030311155409.GB7641@oasis.frogfoot.net> from "Abraham van der Merwe" at Mar 11, 3 05:54:09 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Also, if I compile the kernel with all debugging enabled (CONFIG_DEBUG_SLAB,
> etc) I can reliably trigger the BUG() on line 1263 in mm/slab.c

How does backtrace oops look?

Alexey
