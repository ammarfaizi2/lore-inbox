Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWJVWAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWJVWAi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750698AbWJVWAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:00:37 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50083 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750705AbWJVWAh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:00:37 -0400
Message-ID: <453BEA00.4000601@garzik.org>
Date: Sun, 22 Oct 2006 18:00:32 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: make pdfdocs broken in 2.6.19rc2 and needs fixes
References: <200610222347.42418.ak@suse.de>
In-Reply-To: <200610222347.42418.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> When you do make pdfdocs  with 2.6.19rc2-git7 you get tons of error 
> messages and  then some corrupted PDFs in the end.
> 
> Fixing that (I suppose it will just need comment fixes and
> should not affect the code) should be a relatively easy task for 
> a newbie and  would be useful for the 2.6.19 release.

What userland were you using?  Unfortunately with 'make *docs' that matters.

Unquestionably, there is breakage regardless of distro.

	Jeff



