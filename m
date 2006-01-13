Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422715AbWAMPPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWAMPPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWAMPPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:15:09 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:10920 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1422715AbWAMPPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:15:07 -0500
Date: Fri, 13 Jan 2006 16:15:08 +0100
From: Sander <sander@humilis.net>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Neil Brown <neilb@suse.de>
Subject: Remove slashed from disk names when creation dev names in sysfs patch in stable? (was: Re: [PATCH 00/17] -stable review)
Message-ID: <20060113151508.GA3338@favonius>
Reply-To: sander@humilis.net
References: <20060113032102.154909000@sorel.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113032102.154909000@sorel.sous-sol.org>
X-Uptime: 15:31:16 up 57 days,  5:06, 34 users,  load average: 4.59, 3.93, 3.72
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Shouldn't Neil Brown's patch be included in -stable too? It lets one use
software raid on top of a Promise SX8 SATA controller:

http://www.ussg.iu.edu/hypermail/linux/kernel/0601.1/1634.html

To my untrained eyes the patch seems simple enough, and it fixes a real
bug.

Please forgive me if this is not proper -stable material.

	Kind regards, Sander
