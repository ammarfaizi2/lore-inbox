Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267635AbRGNM1r>; Sat, 14 Jul 2001 08:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267640AbRGNM1h>; Sat, 14 Jul 2001 08:27:37 -0400
Received: from [193.120.224.170] ([193.120.224.170]:59791 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S267637AbRGNM1Q>;
	Sat, 14 Jul 2001 08:27:16 -0400
Date: Sat, 14 Jul 2001 13:27:37 +0100 (IST)
From: Paul Jakma <paulj@alphyra.ie>
To: Andreas Dilger <adilger@turbolinux.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64 bit scsi read/write
In-Reply-To: <200107132204.f6DM4TR3014602@webber.adilger.int>
Message-ID: <Pine.LNX.4.33.0107141325460.1063-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2001, Andreas Dilger wrote:

> put your journal on NVRAM, you will have blazing synchronous I/O.

so ext3 supports having the journal somewhere else then. question: can
the journal be on tmpfs?

> Cheers, Andreas

--paulj

