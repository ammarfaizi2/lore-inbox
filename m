Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWCHMWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWCHMWs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 07:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWCHMWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 07:22:47 -0500
Received: from math.ut.ee ([193.40.36.2]:8339 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932513AbWCHMWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 07:22:46 -0500
Date: Wed, 8 Mar 2006 14:07:15 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Adrian Bunk <bunk@stusta.de>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: spontaneous reboots with latest 2.6.16 RC-s
In-Reply-To: <20060305162905.GC20287@stusta.de>
Message-ID: <Pine.SOC.4.61.0603081404020.1572@math.ut.ee>
References: <Pine.SOC.4.61.0603021501560.23598@math.ut.ee>
 <20060305162905.GC20287@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It could be, but it could also be hardware.
> Does the machine survive a night of memtest86?

Yes, it survived.

Though I found 3 bulging capacitors (no leak yet) ...

> Please turn on all debugging options in the kernel.

Running this kernel since, still have not been able to reproduce the 
problem.

-- 
Meelis Roos (mroos@linux.ee)
