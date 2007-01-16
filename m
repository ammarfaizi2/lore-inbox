Return-Path: <linux-kernel-owner+w=401wt.eu-S932207AbXAPBvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbXAPBvt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 20:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbXAPBvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 20:51:49 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51575 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932207AbXAPBvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 20:51:48 -0500
Message-ID: <45AC2FB0.9000403@garzik.org>
Date: Mon, 15 Jan 2007 20:51:44 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: Jens Axboe <jens.axboe@oracle.com>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbri?= =?ISO-8859-1?Q?nk?= 
	<B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Subject: Re: SATA exceptions with 2.6.20-rc5
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AAC039.1020808@shaw.ca> <45AAC95B.1020708@garzik.org> <45AAE635.8090308@shaw.ca> <20070115025319.GC4516@kernel.dk> <45AB84D8.3020507@garzik.org> <20070116002336.GB4067@kernel.dk> <45AC1E18.8030403@shaw.ca>
In-Reply-To: <45AC1E18.8030403@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Note that the ATA-7 spec for FLUSH CACHE says that "This command may 
> take longer than 30 s to complete."

Yep...

	Jeff


