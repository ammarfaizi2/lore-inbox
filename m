Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbUBQLsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 06:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266142AbUBQLsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 06:48:25 -0500
Received: from gprs155-60.eurotel.cz ([160.218.155.60]:44417 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266140AbUBQLsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 06:48:23 -0500
Date: Tue, 17 Feb 2004 12:47:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: "Brown, Len" <len.brown@intel.com>, trelane@digitasaru.net,
       bluefoxicy@linux.net, linux-kernel@vger.kernel.org
Subject: Re: ACPI -- Workaround for broken DSDT
Message-ID: <20040217114755.GA392@elf.ucw.cz>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A85@hdsmsx402.hd.intel.com> <20040202083836.A20843@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202083836.A20843@lists.us.dell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > For non-vendor supplied solutions, you might also follow the DSDT link
> > here: http://acpi.sourceforge.net/  
> 
> Len, this is a really good idea making this available.  May I suggest
> you also have people provide patches between the original and their
> modified versions, so it's easy for everyone to see what was
> changed?

Patches are important because some DSDTs change with memory sizes,
too, so its safer to patch than to replace.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
