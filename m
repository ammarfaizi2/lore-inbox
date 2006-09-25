Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWIYUhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWIYUhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWIYUhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:37:24 -0400
Received: from server6.greatnet.de ([83.133.96.26]:42721 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1751127AbWIYUhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:37:23 -0400
Message-ID: <45183E12.1080503@nachtwindheim.de>
Date: Mon, 25 Sep 2006 22:37:38 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata-piix: kerneldoc-error-on-ata_piixc.patch 2nd try
References: <451826BE.2040201@nachtwindheim.de>	<4518305C.3090906@pobox.com> <20060925131151.4f73612c.rdunlap@xenotime.net> <45183880.40003@pobox.com>
In-Reply-To: <45183880.40003@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik schrieb:
> Randy Dunlap wrote:
>> I agree with all of these except #4.  Maybe you can reconcile your
>> preference with that in Documentation/SubmittingPatches, which
>> contains:
>>
>> <quote>
>> The canonical patch message body contains the following:
>>
>>   - A "from" line specifying the patch author.
>> </quote>
>>
>> A patch submitter should not need to know the patch receiver's
>> personal preferences and vary patches based on those.
> 
> 
> It's not a personal preference.  It's all based on git-applymbox, pretty
> much.
> 
> The SubmittingPatches doc should be updated to clarify that a From line
> is not needed in the email body, if it is the same as the From line in
> the RFC822 header.
> 
>     Jeff
Thanks for pointing my nose on this guys! I'll keep that in mind when writing patches, but that from line
should be discussed by the maintainers.

Greets and thanks,
Henne
