Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRCLFAP>; Mon, 12 Mar 2001 00:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129496AbRCLFAF>; Mon, 12 Mar 2001 00:00:05 -0500
Received: from [216.161.55.93] ([216.161.55.93]:53757 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S129495AbRCLE7z>;
	Sun, 11 Mar 2001 23:59:55 -0500
Date: Sun, 11 Mar 2001 21:03:09 -0800
From: Greg KH <greg@wirex.com>
To: Martin Bruchanov <bruchm@pytlik.racom.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20010311210309.D19626@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>,
	Martin Bruchanov <bruchm@hnilux.racom.cz>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200103111706.SAA18394@hnilux.racom.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103111706.SAA18394@hnilux.racom.cz>; from bruchm@hnilux.racom.cz on Sun, Mar 11, 2001 at 06:06:24PM +0100
X-Operating-System: Linux 2.4.2-ac14 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2001 at 06:06:24PM +0100, Martin Bruchanov wrote:
> 
> Bug report from Martin Bruchanov (bruxy@kgb.cz, bruchm@racom.cz)
> 
> ############################################################################
> [1.] One line summary of the problem:    
> USB doesn't work properly with SMP kernel on dual-mainboard or with APIC.

What kind of motherboard is this?

And does USB work in SMP mode with "noapic" given on the kernel command
line?

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
