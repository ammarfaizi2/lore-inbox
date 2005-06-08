Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVFHWCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVFHWCR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 18:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVFHWCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 18:02:17 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:47653 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262092AbVFHWCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 18:02:15 -0400
X-IronPort-AV: i="3.93,184,1115010000"; 
   d="scan'208"; a="252199580:sNHT35527660"
Date: Wed, 8 Jun 2005 17:02:14 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Dell BIOS and HPET timer support
Message-ID: <20050608220214.GE21704@lists.us.dell.com>
References: <9e47339105060813115d01282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105060813115d01282@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 04:11:39PM -0400, Jon Smirl wrote:
> After several communications with Dell support I have determined that
> most Dell BIOSs don't include the ACPI entry for the HPET timer. The
> official reason for this is that no version of Windows uses the HPET
> and adding the ACPI entry might cause compatibility problems.

What platform/BIOS version please?  PowerEdge x8xx servers certainly
do have HPET enabled in their ACPI tables.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
