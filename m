Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWDZL3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWDZL3p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 07:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWDZL3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 07:29:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:23766 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932400AbWDZL3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 07:29:24 -0400
From: Andi Kleen <ak@suse.de>
To: Kimball Murray <kimball.murray@gmail.com>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Wed, 26 Apr 2006 13:27:29 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com,
       natalie.protasevich@unisys.com, len.brown@intel.com,
       linux-acpi@vger.kernel.org
References: <20060425160200.3424.89316.sendpatchset@dhcp83-97.boston.redhat.com>
In-Reply-To: <20060425160200.3424.89316.sendpatchset@dhcp83-97.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261327.29694.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 18:06, Kimball Murray wrote:
> Per Andi Kleen's request, I have made slight changes to the patch I
> submitted last week.  Look for the "snip" further down if you don't
> want to re-read the original post.  Thanks!

Added to my tree thanks.

But next time please don't paste other patches in the introduction.
It makes the patch merging scripts unhappy. Instead just resend the patch 
with the full initial description again. I fixed it up.

Thanks,

-Ando
