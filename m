Return-Path: <linux-kernel-owner+w=401wt.eu-S937424AbWLKSDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937424AbWLKSDL (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937414AbWLKSDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:03:11 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:48102 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937424AbWLKSDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:03:09 -0500
Message-ID: <457D9D5B.2080407@garzik.org>
Date: Mon, 11 Dec 2006 13:03:07 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Greg.Chandler@wellsfargo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Interphase Tachyon drivers missing.
References: <E8C008223DD5F64485DFBDF6D4B7F71D023BAAD3@msgswbmnmsp25.wellsfargo.com>
In-Reply-To: <E8C008223DD5F64485DFBDF6D4B7F71D023BAAD3@msgswbmnmsp25.wellsfargo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg.Chandler@wellsfargo.com wrote:
> I went to upgrade my kernel on a couple of boxes yesterday and noticed
> that the Interphase Tachyon chipset Fibre Channel driver was removed
> from the kernel.  I think 2.6.1 was the last one it was still in.  Was
> there a reason it was pulled?
> If not, do I have to volunteer to put it back in or can someone with
> more skill re-add it?

It was dropped because it was unmaintained, and quickly falling behind 
mainline.  If it's a maintained driver with an active userbase, we're 
interested...

	Jeff



