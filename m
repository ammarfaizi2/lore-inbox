Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUBEKh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 05:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbUBEKh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 05:37:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54197 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261606AbUBEKh2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 05:37:28 -0500
Message-ID: <40221CDA.5040008@pobox.com>
Date: Thu, 05 Feb 2004 05:37:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
References: <20040205014405.5a2cf529.akpm@osdl.org> <20040205100004.A5426@flint.arm.linux.org.uk>
In-Reply-To: <20040205100004.A5426@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Feb 05, 2004 at 01:44:05AM -0800, Andrew Morton wrote:
> 
>> bk-netdev.patch
> 
> 
> Does this include the changes to all those PCMCIA net drivers which
> Jeff has had for a while from me?

Yes


> I'd like to get those patches into mainline so I can close bugme bug
> 1711, but I think Jeff's waiting for responses from the individual
> net driver maintainers first. ;(

Nope, was just waiting for 2.6.2 to be released.  The first post-262 
batch has been merged, am now sending the second batch.  Yours is in the 
third batch :)

	Jeff



