Return-Path: <linux-kernel-owner+w=401wt.eu-S1422694AbWLPWb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422694AbWLPWb0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 17:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWLPWb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 17:31:26 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:36655 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422694AbWLPWbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 17:31:25 -0500
Message-ID: <458473B0.3020102@garzik.org>
Date: Sat, 16 Dec 2006 17:31:12 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <jens.axboe@oracle.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc1
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612150141.09020.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612161326120.3479@woody.osdl.org> <200612162228.06913.s0348365@sms.ed.ac.uk>
In-Reply-To: <200612162228.06913.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> It could simply be that bisect isn't working here because it's actually broken
> by two separate patches. Out of bad luck, I've ended up singling out the one
> that already has a "fix", and the "real bug" hasn't been found.
> 
> I guess I should repeat the bisection, and when the bio-fix isn't applied,
> manually apply it? Is there some magical Git way to do this?
> 
> Here's the bisection log, for what it's worth;


This may be totally subjective on my part, but if I get stuck (and I 
have the patience) I sometimes like to look at the log and try to pick 
arbitrary 'good' points, to stir the pot a bit.

	Jeff


