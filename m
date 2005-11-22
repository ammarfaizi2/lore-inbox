Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVKVJEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVKVJEf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 04:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVKVJEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 04:04:35 -0500
Received: from [85.8.13.51] ([85.8.13.51]:46238 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751280AbVKVJEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 04:04:34 -0500
Message-ID: <4382DF18.5040400@drzeus.cx>
Date: Tue, 22 Nov 2005 10:04:24 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Secure Digital Host Controller PCI class
References: <4381B364.2020808@drzeus.cx> <20051121214733.GA17793@suse.de> <4382B596.5080001@drzeus.cx> <20051122063904.GA24853@suse.de>
In-Reply-To: <20051122063904.GA24853@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>
> I do have access to the PCI specs from the SIG website by virtue of my
> current employer, not by any recognition by the PCI-SIG that Linux is
> important at all...
>
> If you let me know what document you think this might be in, I'll dig
> around to see if I can find it.
>
>   

It's difficult to tell what is inside each document without being a
member. But this sounds promising:

Appendix D -- Class codes updates
<http://www.pcisig.com/members/downloads/specifications/conventional/appd_latest.pdf>
(61k PDF)
http://www.pcisig.com/members/downloads/specifications/conventional/appd_latest.pdf

> Nice, thanks for the link.
>
> But how about I wait to add your patch, until you submit your driver
> that needs that change?  At that time I'll be glad to add it.
>
>   

That was the idea. I just wanted to get comments early on. This part
will probably not change so I might as well have it reviewed now.

Rgds
Pierre

