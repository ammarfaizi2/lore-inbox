Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWDZNR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWDZNR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWDZNR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:17:26 -0400
Received: from mx1.suse.de ([195.135.220.2]:38578 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932428AbWDZNRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:17:25 -0400
From: Andi Kleen <ak@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Wed, 26 Apr 2006 15:17:05 +0200
User-Agent: KMail/1.9.1
Cc: "Kimball Murray" <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com, kmurray@redhat.com, natalie.protasevich@unisys.com,
       linux-acpi@vger.kernel.org
References: <CFF307C98FEABE47A452B27C06B85BB6466487@hdsmsx411.amr.corp.intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6466487@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604261517.06505.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 21:53, Brown, Len wrote:
> I'd rather see the original irq-renaming patch
> and its subsequent multiple via workaround patches
> reverted than to further complicate what is becoming
> a fragile mess.

Sorry rechecking - i already got the patch now. You want me to drop it again?

I guess we could drop it all, but VIA must still work afterwards.
How would we do that?

-Andi
