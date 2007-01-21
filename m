Return-Path: <linux-kernel-owner+w=401wt.eu-S1751059AbXAUDef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbXAUDef (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 22:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXAUDef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 22:34:35 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:59717 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbXAUDef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 22:34:35 -0500
Message-ID: <45B2DF43.8080304@garzik.org>
Date: Sat, 20 Jan 2007 22:34:27 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: Chr <chunkeey@web.de>, Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com
Subject: Re: SATA exceptions with 2.6.20-rc5
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca> <200701202332.58719.chunkeey@web.de> <45B2C6E1.9000901@shaw.ca>
In-Reply-To: <45B2C6E1.9000901@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> change in 2.6.20-rc is either causing or triggering this problem. It 
> would be useful if you could try git bisect between 2.6.19 and 
> 2.6.20-rc5, keeping the latest sata_nv.c each time, and see if that 


Yes, 'git bisect' would be the next step in figuring out this puzzle.

Anybody up for it?

	Jeff


