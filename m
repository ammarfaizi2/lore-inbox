Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266224AbUHNWB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUHNWB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 18:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUHNWB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 18:01:26 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:44995 "EHLO
	stout.engsoc.org") by vger.kernel.org with ESMTP id S266220AbUHNWBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 18:01:08 -0400
Date: Sat, 14 Aug 2004 17:58:00 -0400
From: Kyle McMartin <kyle@debian.org>
To: Brannon Klopfer <plazmcman@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic, 2.6.8
Message-ID: <20040814215800.GO11649@engsoc.org>
References: <411E87A7.1000500@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411E87A7.1000500@softhome.net>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 02:44:07PM -0700, Brannon Klopfer wrote:
> I fired up my tower (2.6.7), ssh'ed into it with my laptop (2.6.7), and 
> compiled it (my laptop's a lot slower than my tower). Then I downloaded, 
> via NFS, the 2.6.8 modules, kernel, and System.map onto my laptop. Then 
> I upgraded the tower. Rebooted, both running 2.6.8, so far so good. 
> Wanted to fine-tune the kernel config, so I did the whole process over: 
> However, "cp" segfaulted when trying to copy the kernel/System.map:
> 
http://ftp.kernel.org/pub/linux/kernel/v2.6/LATEST-IS-2.6.8.1
http://ftp.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.8.1

Cheers,
-- 
Kyle McMartin
