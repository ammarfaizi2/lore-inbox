Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWBXCh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWBXCh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 21:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWBXCh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 21:37:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:46485 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751815AbWBXChZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 21:37:25 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: Suppress APIC errors on UP x86-64.
Date: Fri, 24 Feb 2006 03:37:12 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060224014228.GB16089@redhat.com> <200602240318.12239.ak@suse.de> <20060224022701.GJ23471@redhat.com>
In-Reply-To: <20060224022701.GJ23471@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602240337.13214.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 03:27, Dave Jones wrote:

> From first impression, it seems they're all (including mine) HP laptops
> with ATI chipsets.

Ah that chipset from hell.

> I wonder if this is related at all to the 'time goes double speed'
> bug that some folks see (incidentally, I don't on mine).
> 

Very likely is.

-Andi
