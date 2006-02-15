Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWBRMzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWBRMzH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWBRMzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:55:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27035 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751213AbWBRMzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:55:06 -0500
Date: Thu, 16 Feb 2006 00:43:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060215234317.GC3490@openzaurus.ucw.cz>
References: <200602131116.41964.david-b@pacbell.net> <43F0E724.6000807@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F0E724.6000807@cfl.rr.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are you quite certain about that?  This is not 
> the case for SCSI disks, but for USB, maybe it 
> can provide sufficient information to the 
> kernel about state changes without having to do 
> a full rescan.  If that is the case, and the 
> hardware is erroneously reporting that all 
> devices were disconnected and reconnected after 
> an ACPI suspend to disk, then such hardware is 
> broken and the kernel should be patched to work 
> around it. 

No patch was attached...

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

