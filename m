Return-Path: <linux-kernel-owner+w=401wt.eu-S932345AbXAGC2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbXAGC2T (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbXAGC2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:28:19 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37340 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932345AbXAGC2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:28:18 -0500
Date: Sun, 7 Jan 2007 02:38:51 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] DAC960: kmalloc->kzalloc/Casting cleanups
Message-ID: <20070107023851.07858f50@localhost.localdomain>
In-Reply-To: <20070107020010.GH19020@Ahmed>
References: <20070106131725.GB19020@Ahmed>
	<20070106094630.51aa62e8.randy.dunlap@oracle.com>
	<20070107020010.GH19020@Ahmed>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Should Kernel janitors then care of cleaning orphaned files ?.

If you have the hardware to run tests then yes, if not then they are best
handled with caution. Working is preferred to pretty.

Alan
