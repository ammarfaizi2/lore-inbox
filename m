Return-Path: <linux-kernel-owner+w=401wt.eu-S964777AbWLNVyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWLNVyI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWLNVyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:54:08 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:49899 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964777AbWLNVyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:54:07 -0500
Message-ID: <4581C7EC.6020104@garzik.org>
Date: Thu, 14 Dec 2006 16:53:48 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux 2.6.20-rc1
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612142113.41135.s0348365@sms.ed.ac.uk> <4581C345.2070600@garzik.org> <200612142144.26023.s0348365@sms.ed.ac.uk>
In-Reply-To: <200612142144.26023.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> Before I proceed with the horrors of an -rc1 bisection, could somebody send me 
> the ADMA patches so I can eliminate those first?


BTW a bisection need not be blindly horrific...  You can look at the 
commit ids from git-whatchanged output mentioned in the previous email, 
and make educated guesses about what might be a good or bad change.

	Jeff


