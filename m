Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289776AbSAOOmy>; Tue, 15 Jan 2002 09:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289821AbSAOOmp>; Tue, 15 Jan 2002 09:42:45 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:31405 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S289776AbSAOOma>; Tue, 15 Jan 2002 09:42:30 -0500
Date: Tue, 15 Jan 2002 09:46:12 -0500
To: k.meyer@m3its.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: highmem=system killer, 2.2.17=performance killer ?
Message-ID: <20020115094612.A6036@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i've got serious problems using 2.4.x kernels using highmem support.
> It seems to me that i'm not the only one, but the difference to most
> other ones is,
> that i can't use highmem because the system performance is terrible
> slow.

Klaus,

Have you tried 2.4.18pre2aa2 from:
ftp://ftp.de.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre2aa2.bz2

With this patch applied:
http://marc.theaimsgroup.com/?l=linux-kernel&m=101110373911359&w=2

I get better performance with it, but I've only used it on
a machine with 1GB ram.

-- 
Randy Hron

