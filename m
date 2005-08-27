Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbVH0CUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbVH0CUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 22:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbVH0CUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 22:20:05 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:22763 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751632AbVH0CUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 22:20:02 -0400
Subject: Re: [PATCH 6/7] [PATCH] sg.c: fix a memory leak in devices
	seq_file implementation (2nd)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, stable@kernel.org,
       Ingo Oeser <ioe-lkml@rameria.de>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Jan Blunck <j.blunck@tu-harburg.de>
In-Reply-To: <20050826191942.444423000@localhost.localdomain>
References: <20050826191755.052951000@localhost.localdomain>
	 <20050826191942.444423000@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 21:19:51 -0500
Message-Id: <1125109191.5079.157.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 12:18 -0700, Chris Wright wrote:
> plain text document attachment (fix-memory-leak-in-sg.c-
> seq_file.patch)
> -stable review patch.  If anyone has any  objections, please let us know.

Looks fine to me.

James


