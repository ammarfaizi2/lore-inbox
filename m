Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286615AbSAMDmn>; Sat, 12 Jan 2002 22:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287337AbSAMDmd>; Sat, 12 Jan 2002 22:42:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54992 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286615AbSAMDmX>;
	Sat, 12 Jan 2002 22:42:23 -0500
Date: Sat, 12 Jan 2002 22:42:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andreas Schuldei <andreas@schuldei.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops in the filesystem code (ext3) during find (cron)
In-Reply-To: <20020110220928.GA975@sigrid.schuldei.com>
Message-ID: <Pine.GSO.4.21.0201122238270.24774-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Jan 2002, Andreas Schuldei wrote:

> I regularly get this oops during daily cron jobs.
> 
> uname -a
> Linux johannes 2.4.17-pre6 #4 Sat Dec 15 21:54:55 CET 2001 i686
> ext3 fs
> 
> i think i can reproduce this at will for debugging.

[snip]

ksymoops output for the first trace looks bogus.  Could you post/mail
the raw oops data?

