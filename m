Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSGLNkC>; Fri, 12 Jul 2002 09:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSGLNkB>; Fri, 12 Jul 2002 09:40:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39172 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316408AbSGLNkA>; Fri, 12 Jul 2002 09:40:00 -0400
Subject: Re: IDE/ATAPI in 2.5
To: szepe@pinerecords.com (Tomas Szepe)
Date: Fri, 12 Jul 2002 15:06:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020712130702.GL29993@louise.pinerecords.com> from "Tomas Szepe" at Jul 12, 2002 03:07:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17T13m-000343-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In other words nobody who understands IDE is for and everyone who 
> > understands you can't actually get rid of ide-floppy, tape, cdrom internal
> > support and knows about IDE is..
> > 
> > > Against:
> > > 1. Bart=B3omiej =AFo=B3nierkiewcz.
> > > 
> > 
> > against..
> 
> Very well put.

Note I completely agree with people that from a user space perspective they
shouldn't be jumping through hoops trying to work out what shape of device
it is just to use it at all.
