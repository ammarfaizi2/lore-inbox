Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261674AbTCZNKa>; Wed, 26 Mar 2003 08:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261675AbTCZNKa>; Wed, 26 Mar 2003 08:10:30 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:28319 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261674AbTCZNK3>; Wed, 26 Mar 2003 08:10:29 -0500
Subject: Re: LVM/Device mapper breaks with -mm (was: Re: 2.5.66-mm1)
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048684899.11019.15.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Mar 2003 08:21:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Andrew Morton (akpm@digeo.com) wrote: 
>
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.66/2.5.66-mm1/

LVM or device mapper seems to be broken in -mm. I've only tried the 
following kernels so far: 
2.5.64 - works 
2.5.65-mm2 - doesn't work 
2.5.66 - works 
2.5.66-mm1 - doesn't work

Just another data point. LVM in -mm stopped working for me at
2.5.65-mm2, it did work in 2.5.65-mm1. 2.5.65-mm[234] did not work
either.

Regards,

Shane

