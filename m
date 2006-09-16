Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWIPGSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWIPGSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 02:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWIPGSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 02:18:36 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8861 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932202AbWIPGSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 02:18:36 -0400
Message-ID: <450B9739.5030009@garzik.org>
Date: Sat, 16 Sep 2006 02:18:33 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Tom Mortensen <tmmlkml@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x libata resync
References: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com>
In-Reply-To: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Mortensen wrote:
> I was wondering if there are any plans for another resync of the latest
> 2.6.x libata changes back into the 2.4.x kernel?

No plans from me, anyway.

The 2.6.x SCSI API is quite different from the 2.4 API.  Dropping 2.4 
support removed a lot of limitations on the codebase, and allowed 
accelerated development.

That shouldn't stop any sufficiently motivated 3rd party, though...

	Jeff


