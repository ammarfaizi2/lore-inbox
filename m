Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbUKCMaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbUKCMaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 07:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbUKCMaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 07:30:08 -0500
Received: from main.gmane.org ([80.91.229.2]:58598 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261572AbUKCMaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 07:30:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Seyfried <seife@suse.de>
Subject: Re: 2.6.8 Thinkpad T40, clock running too fast
Date: Wed, 3 Nov 2004 12:29:58 +0000 (UTC)
Message-ID: <20041103122852.GA23700@foxi.suse.de>
References: <200411021551.53253.shawn-lkml@willden.org> <1099436816.9139.28.camel@cog.beaverton.ibm.com> <200411021738.59657.shawn-lkml@willden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: charybdis-ext.suse.de
Content-Disposition: inline
In-Reply-To: <200411021738.59657.shawn-lkml@willden.org>
X-Operating-System: SuSE Linux 9.2 (x86-64), Kernel 2.6.8-24.3-default
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 05:38:53PM -0700, Shawn Willden wrote:
 
> Any ideas?

remove /etc/adjtime and reboot.
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."

