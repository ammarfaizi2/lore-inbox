Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbSJ1Bht>; Sun, 27 Oct 2002 20:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSJ1Bhs>; Sun, 27 Oct 2002 20:37:48 -0500
Received: from c-24-118-232-93.mn.client2.attbi.com ([24.118.232.93]:48046
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262806AbSJ1Bhr>; Sun, 27 Oct 2002 20:37:47 -0500
Date: Sun, 27 Oct 2002 19:44:01 -0600 (CST)
From: Scott Hoffman <scott781@attbi.com>
To: Mudit Goel <muditgoel@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: booting after new Kernel compile reboots laptop automatically
In-Reply-To: <20021027225354.57486.qmail@web13101.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0210271941320.27031-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Oct 2002, Mudit Goel wrote:

> My computer is Toshiba 1555cds satellite K6-2 - 380
> MHz - 4.3 GB HD - 160 MB RAM 
> 
> Could anyone help me with this? I am attaching the
> linux compilation .config file, along with
> /var/log/boot.log
> 
> -------------
> .config
> # Processor type and features
> #
> # CONFIG_M386 is not set
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> CONFIG_MPENTIUMIII=y
> # CONFIG_MPENTIUM4 is not set
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set

Hi,
  I think you'll be wanting to change your processor to K6 instead of 
Pentium III.

Cheers,
Scott Hoffman

