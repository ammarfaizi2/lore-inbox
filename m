Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267787AbRGUT67>; Sat, 21 Jul 2001 15:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267797AbRGUT6t>; Sat, 21 Jul 2001 15:58:49 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:64470 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S267787AbRGUT6l>;
	Sat, 21 Jul 2001 15:58:41 -0400
Message-Id: <m15O2tS-000P5WC@amadeus.home.nl>
Date: Sat, 21 Jul 2001 20:58:30 +0100 (BST)
From: arjan@fenrus.demon.nl
To: mmiles@alacritech.com (Michael S. Miles)
Subject: Re: kgdb and/or kdb for RH7.1
CC: linux-kernel@vger.kernel.org
In-Reply-To: <KIEKJCGPOOADIOGPDJJLOEPGEFAA.mmiles@alacritech.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <KIEKJCGPOOADIOGPDJJLOEPGEFAA.mmiles@alacritech.com> you wrote:
> Does anyone know if patches exist against the stock RedHat 7.1
> kernel(2.4.2-2) to support remote kernel debugging(kgdb).  I would also be
> interested in the same for kdb, but I'm primarily interested in kgdb.

> If it doesn't exist I guess I will have to try to port the patches over
> myself, I just didn't want to reinvent the wheel.

Look in the src.rpm for the kernel, there's a ikd patch there...

