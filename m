Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbUCTNqd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 08:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUCTNqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 08:46:33 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:42205 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263409AbUCTNqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 08:46:31 -0500
Subject: Re: [patch] 2.6.5-rc2: fix scsi_transport_spi.c with gcc 2.95
From: James Bottomley <James.Bottomley@steeleye.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Martin Hicks <mort@wildopensource.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20040320121853.GF19464@fs.tum.de>
References: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org> 
	<20040320121853.GF19464@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 20 Mar 2004 08:43:08 -0500
Message-Id: <1079790194.1778.0.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-20 at 07:18, Adrian Bunk wrote:
> I found the patch below in -mm that fixes this problem.

I already have the mm patch in scsi-misc-2.5.

Thanks,

James


