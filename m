Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319347AbSIKVcY>; Wed, 11 Sep 2002 17:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319350AbSIKVcY>; Wed, 11 Sep 2002 17:32:24 -0400
Received: from pD9E23FF5.dip.t-dialin.net ([217.226.63.245]:26077 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319347AbSIKVcY>; Wed, 11 Sep 2002 17:32:24 -0400
Date: Wed, 11 Sep 2002 15:37:22 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Phil Stracchino <alaric@babcom.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: CDROM driver does not support Linux partition tables
In-Reply-To: <20020911211959.GA31724@babylon5.babcom.com>
Message-ID: <Pine.LNX.4.44.0209111534430.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Sep 2002, Phil Stracchino wrote:
> A deficiency in the Linux CDROM driver was just brought to my attention.
> Even on a kernel configured with support for UFS and Sun partition
> tables, it doesn't appear to be possible to mount any but the first
> slice of a Sun CDROM containing multiple slices.  Essentially, it seems
> that Solaris partition table support doesn't trickle down to the CDROM
> driver.

I remember someone tangling around with the partitioning code. Care to 
comment?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

