Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWI3QHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWI3QHc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 12:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWI3QHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 12:07:32 -0400
Received: from mail.suse.de ([195.135.220.2]:42461 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751249AbWI3QHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 12:07:31 -0400
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: [PATCH 0 of 4] x86-64: Calgary IOMMU updates
Date: Sat, 30 Sep 2006 18:07:25 +0200
User-Agent: KMail/1.9.3
Cc: jdmason@kudzu.us, linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <patchbomb.1159605808@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1159605808@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609301807.25238.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 September 2006 10:43, Muli Ben-Yehuda wrote:
> Hi Andi,
> 
> [resending with proper CC's].
> 
> Please apply this Calgary patchset. It fixes one bug
> (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=203971, should
> go to -stable as well) and makes several other updates all of which
> are safe for 2.6.19. Each patch has a detailed description.

Merged thanks.

It would be good if you could use a less weird patch format in the future 
though. In particular diffstat should be at the end and any other weird
metadata too. And the Subject shouldn't be wrapped.

Thanks,

-Andi
