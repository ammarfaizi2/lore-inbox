Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTJGQy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbTJGQy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:54:27 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14829 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262525AbTJGQyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:54:24 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linuxcompilerdd <linuxcompiler@yahoo.es>
Subject: Re: hello, i need some help
Date: Tue, 7 Oct 2003 18:57:33 +0200
User-Agent: KMail/1.5.4
References: <1065544070.4385.6.camel@skynet.gml>
In-Reply-To: <1065544070.4385.6.camel@skynet.gml>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310071857.33164.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.5.xx is quite old, use 2.6.0-testX (2.6.0-test6 is the latest/greatest).

On Tuesday 07 of October 2003 18:36, linuxcompilerdd wrote:
> Hello,
>
> I have a problem booting the kernel.
> Now i am using kernel 2.4.20 and it is working nice but when I try to boot
> 2.5.xx I obtain this error:
> VFS:cannot open root device "hdb5" or hdb5
>
> After working on it, now I am sure that the problem is on the hard disk
> because I have an AWARD 4.51 and my hdb is an 60Gb disk so I use the STROKE
> from SEAGATE to use it.
> I don`t have any problem on 2.x.xx but I cannot boot on it now.
> I have booted the same kernel that displayed the error in other system and
> it booted perfectly, so the problem resides on the hdb.
>
> I wish you could help me resolving it, maybe a patch for the drive...
>
> I hope your answer.
> Thank u
>
> Guille

