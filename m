Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbRCALLn>; Thu, 1 Mar 2001 06:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129155AbRCALLd>; Thu, 1 Mar 2001 06:11:33 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:8458
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129137AbRCALLZ>; Thu, 1 Mar 2001 06:11:25 -0500
Date: Thu, 1 Mar 2001 03:10:53 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Eduard Hasenleithner <eduardh@aon.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to set hdparms for ide-scsi devices on devfs?
In-Reply-To: <20010228224850.A10608@moserv.hasi>
Message-ID: <Pine.LNX.4.10.10103010310070.6914-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


procfs

echo unmaskirq:1 /proc/ide/hdx/settings

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

