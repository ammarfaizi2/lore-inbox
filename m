Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265630AbUBBOil (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 09:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUBBOil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 09:38:41 -0500
Received: from lists.us.dell.com ([143.166.224.162]:30677 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265630AbUBBOij
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 09:38:39 -0500
Date: Mon, 2 Feb 2004 08:38:36 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: trelane@digitasaru.net, bluefoxicy@linux.net, linux-kernel@vger.kernel.org
Subject: Re: ACPI -- Workaround for broken DSDT
Message-ID: <20040202083836.A20843@lists.us.dell.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A85@hdsmsx402.hd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0CC8A85@hdsmsx402.hd.intel.com>; from len.brown@intel.com on Sun, Feb 01, 2004 at 11:33:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 11:33:44PM -0500, Brown, Len wrote:
> For non-vendor supplied solutions, you might also follow the DSDT link
> here: http://acpi.sourceforge.net/  

Len, this is a really good idea making this available.  May I suggest
you also have people provide patches between the original and their
modified versions, so it's easy for everyone to see what was changed?

Thanks,
Matt (who's not looking forward to pulling 20 systems from the
hardware library and flashing BIOSses to pull the original DSDT to
compare with what users suggest need to be fixed for each one before
he can file bug reports with the BIOS writers...)

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
