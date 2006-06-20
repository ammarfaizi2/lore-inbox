Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWFTVVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWFTVVq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWFTVVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:21:45 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:12514 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751113AbWFTVVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:21:44 -0400
Message-ID: <449866E3.8010200@garzik.org>
Date: Tue, 20 Jun 2006 17:21:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] SCSI updates for 2.6.17
References: <1150837947.2531.27.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1150837947.2531.27.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> This represents the almost complete SCSI pending list apart from a SAS
> port update which we're still trying to beat into shape.  The patch can
> be pulled from here:

When will aic94xx head upstream?  Even though it is seeing changes in 
your repo, I would rather not hide the driver for another six months.

aic94xx is the only all-software-stack SAS user at present, so I think 
its reasonable to get it into the tree, and make changes upstream.

	Jeff



