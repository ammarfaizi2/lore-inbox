Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263567AbUERUiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbUERUiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 16:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUERUiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 16:38:52 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:10132 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263563AbUERUit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 16:38:49 -0400
Subject: Re: [BK PATCH] SCSI updates for 2.6.6
From: James Bottomley <James.Bottomley@steeleye.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kurt Garloff <garloff@suse.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0405182140050.3207-100000@poirot.grange>
References: <Pine.LNX.4.44.0405182140050.3207-100000@poirot.grange>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 May 2004 15:38:43 -0500
Message-Id: <1084912724.2101.44.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-18 at 14:47, Guennadi Liakhovetski wrote:
> Well, Kurt, thanks for the offer. I am prepared and willing to do the work
> on supporting the driver, but I am, perhaps, not skilled enough to be a
> maintainer of a SCSI LDD. My knowledge of the SCSI protocol and the SCSI
> Linux subsystem is pretty limited. On one hand, the driver is little used,
> so, even if I badly break something it is not likely to cause major
> problems. On the other hand, I would feel more comfortable if, at least at
> the beginning, somebody would review my patches. Besides, it would be a
> good opportunity for me to really learn a bit more about SCSI, SCSI Linux
> driver, BIO,...  oh well...

OK, roll up for me what you'd currently like applied to the driver;
anything that's less than solid, I'd rather mature in the -mm tree for a
while.

James


