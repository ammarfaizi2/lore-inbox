Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275334AbTHMSlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275325AbTHMSkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:40:55 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:23289 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S275336AbTHMSjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:39:22 -0400
Subject: Re: IDE bug - was: Re: uncorrectable ext2 errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Niehusmann <jan@gondor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rossb@google.com
In-Reply-To: <20030813163106.GA2664@gondor.com>
References: <20030806150335.GA5430@gondor.com>
	 <1060702567.21160.30.camel@dhcp22.swansea.linux.org.uk>
	 <20030813005057.A1863@pclin040.win.tue.nl>
	 <200308130221.26305.bzolnier@elka.pw.edu.pl>
	 <20030813080309.GB2006@gondor.com>
	 <1060773360.8009.11.camel@localhost.localdomain>
	 <20030813163106.GA2664@gondor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060799934.9130.25.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 19:38:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-13 at 17:31, Jan Niehusmann wrote:
> But I also have some good news: The patch by Ross Biro, available from
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104250818527780&w=2
> actually fixed the hdparm -I crash.

Thanks I'd missed that bug fix somehow

