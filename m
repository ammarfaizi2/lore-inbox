Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267000AbRGSHf4>; Thu, 19 Jul 2001 03:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267009AbRGSHfg>; Thu, 19 Jul 2001 03:35:36 -0400
Received: from zeus.kernel.org ([209.10.41.242]:63418 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S267000AbRGSHfc>;
	Thu, 19 Jul 2001 03:35:32 -0400
Date: Thu, 19 Jul 2001 00:35:04 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 64 bit SCSI read/write
Message-ID: <Pine.LNX.4.10.10107190032320.9036-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well to answer AC's question...we changed the rules in ATA-ATAPI-6 such
that all ATA (harddrives) devices are required to support write/flush
cache commands.


Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

