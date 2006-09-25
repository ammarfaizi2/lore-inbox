Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWIYVWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWIYVWf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWIYVWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 17:22:35 -0400
Received: from xenotime.net ([66.160.160.81]:11440 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751391AbWIYVWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 17:22:34 -0400
Date: Mon, 25 Sep 2006 14:23:46 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Henne <henne@nachtwindheim.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata-piix: kerneldoc-error-on-ata_piixc.patch 2nd try
Message-Id: <20060925142346.cbf0ed6a.rdunlap@xenotime.net>
In-Reply-To: <45183E12.1080503@nachtwindheim.de>
References: <451826BE.2040201@nachtwindheim.de>
	<4518305C.3090906@pobox.com>
	<20060925131151.4f73612c.rdunlap@xenotime.net>
	<45183880.40003@pobox.com>
	<45183E12.1080503@nachtwindheim.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2006 22:37:38 +0200 Henne wrote:

> Jeff Garzik schrieb:
> > Randy Dunlap wrote:
> >> I agree with all of these except #4.  Maybe you can reconcile your
> >> preference with that in Documentation/SubmittingPatches, which
> >> contains:
> >>
> >> <quote>
> >> The canonical patch message body contains the following:
> >>
> >>   - A "from" line specifying the patch author.
> >> </quote>
> >>
> >> A patch submitter should not need to know the patch receiver's
> >> personal preferences and vary patches based on those.
> > 
> > 
> > It's not a personal preference.  It's all based on git-applymbox, pretty
> > much.
> > 
> > The SubmittingPatches doc should be updated to clarify that a From line
> > is not needed in the email body, if it is the same as the From line in
> > the RFC822 header.

It seems to be a small, simple matter of "not needed" vs. "allowed".
AFAIK, From: is always allowed but it is not needed if the From: mail
header matches the From: body text.


> >     Jeff
> Thanks for pointing my nose on this guys! I'll keep that in mind when writing patches, but that from line
> should be discussed by the maintainers.


---
~Randy
