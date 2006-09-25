Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWIYUOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWIYUOD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWIYUOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:14:01 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:1744 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751016AbWIYUOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:14:00 -0400
Message-ID: <45183880.40003@pobox.com>
Date: Mon, 25 Sep 2006 16:13:52 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@xenotime.net>
CC: Henne <henne@nachtwindheim.de>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata-piix: kerneldoc-error-on-ata_piixc.patch 2nd try
References: <451826BE.2040201@nachtwindheim.de>	<4518305C.3090906@pobox.com> <20060925131151.4f73612c.rdunlap@xenotime.net>
In-Reply-To: <20060925131151.4f73612c.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> I agree with all of these except #4.  Maybe you can reconcile your
> preference with that in Documentation/SubmittingPatches, which
> contains:
> 
> <quote>
> The canonical patch message body contains the following:
> 
>   - A "from" line specifying the patch author.
> </quote>
> 
> A patch submitter should not need to know the patch receiver's
> personal preferences and vary patches based on those.


It's not a personal preference.  It's all based on git-applymbox, pretty 
much.

The SubmittingPatches doc should be updated to clarify that a From line 
is not needed in the email body, if it is the same as the From line in 
the RFC822 header.

	Jeff


