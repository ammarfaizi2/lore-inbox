Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271255AbTHMAH4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271262AbTHMAH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:07:56 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:57984 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S271255AbTHMAHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:07:54 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: linux-ia64@vger.kernel.org
Date: Wed, 13 Aug 2003 10:07:51 +1000
Cc: linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
Message-ID: <20030813000751.GD25474@cse.unsw.edu.au>
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com> <16174.59114.386209.649300@wombat.chubb.wattle.id.au> <16174.60868.750901.704560@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16174.60868.750901.704560@napali.hpl.hp.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 04:35:32PM -0700, David Mosberger wrote:
>   David> Now that Linus' tree works for ia64, the next question is how
>   David> we can keep it that way.  I think it would be useful to have
>   David> someone setup a cron job which does daily builds/automated
>   David> tests off of Linus tree. 
> 
>   Peter> We'd probably do daily automated builds to check that the kernel
>   Peter> still compiles cleanly for HPSIM, DIG, and ZX1, but test only weekly.

It has been running OK for a few days now, so please feel free to
check out

http://www.gelato.unsw.edu.au/kerncomp

for the status of daily IA64 builds.  We will attempt to keep track of
what is happening and fix anything that needs fixing or point to where
it has been fixed.

We're still working on automated testing (i.e. booting on the
simulator, maybe real hardware).

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au
