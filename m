Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263573AbUEKTy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbUEKTy4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbUEKTy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:54:56 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:55703 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263366AbUEKTyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:54:53 -0400
Subject: Re: [BK PATCH] SCSI updates for 2.6.6
From: James Bottomley <James.Bottomley@steeleye.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0405112125150.3836-100000@poirot.grange>
References: <Pine.LNX.4.44.0405112125150.3836-100000@poirot.grange>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 May 2004 14:54:33 -0500
Message-Id: <1084305274.2570.12.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 14:29, Guennadi Liakhovetski wrote:
> I hoped the tmscsim 64-bit bugfix would somehow find its way into the
> mainstream after 2.6. Does it still have a chance?

The DC390 is a maintained driver:

DC390/AM53C974 SCSI driver
P:	Kurt Garloff
M:	garloff@suse.de
W:	http://www.garloff.de/kurt/linux/dc390/
S:	Maintained

You need to get the maintainer to approve acceptance.

James


