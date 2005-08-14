Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVHNUPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVHNUPA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 16:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVHNUPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 16:15:00 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46548 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932233AbVHNUO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 16:14:59 -0400
Date: Sun, 14 Aug 2005 21:23:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH]hande sysdev suspend failure
Message-ID: <20050814192341.GA1686@openzaurus.ucw.cz>
References: <1123727859.2918.4.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123727859.2918.4.camel@linux-hp.sh.intel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds the return value check for sysdev suspend and does
> restore in failure case. Send the patch to pm-list, but seems lost, so I
> resend it.

It seems to duplicate code a bit. Can that be fixed?
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

