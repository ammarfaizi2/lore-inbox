Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWEME3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWEME3o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 00:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWEME3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 00:29:44 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:49122 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750861AbWEME3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 00:29:43 -0400
Message-ID: <446560B3.10301@garzik.org>
Date: Sat, 13 May 2006 00:29:39 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Jes Sorensen <jes@sgi.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, akpm@osdl.org, jeremy@sgi.com
Subject: Re: [PATCH] Move various PCI IDs to header file
References: <20060504180614.X88573@chenjesu.americas.sgi.com> <20060504173722.028c2b24.rdunlap@xenotime.net> <445AE690.5030700@sgi.com> <20060505133437.GA24268@kroah.com>
In-Reply-To: <20060505133437.GA24268@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(since I was an instigator here...)

Greg KH wrote:
> No, I agree with your patch, as you are having to reference the ids from
> 2 different files.  So because of that, I feel it's ok to have those ids
> in the pci_id.h file.

Agreed.


> Yes, the wording in the documentation file should be cleaned up a bit to
> state this a bit better...

Agreed.

	Jeff



