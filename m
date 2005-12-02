Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbVLBTvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVLBTvM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 14:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbVLBTvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 14:51:12 -0500
Received: from dsl081-060-252.sfo1.dsl.speakeasy.net ([64.81.60.252]:50825
	"EHLO vitelus.com") by vger.kernel.org with ESMTP id S1750987AbVLBTvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 14:51:11 -0500
Date: Fri, 2 Dec 2005 11:51:09 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Promise SATA oops
Message-ID: <20051202195109.GE3677@vitelus.com>
References: <20051202045853.GD3677@vitelus.com> <438FDB9D.2030201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438FDB9D.2030201@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 12:29:01AM -0500, Jeff Garzik wrote:
> This should be fixed in 2.6.15-rcX...

Still isn't stable. It froze within hours after announcing in all
terminals that it was disabling a certain IRQ. Now the RAID is so
degraded that root can't even be mounted. Was the Promise controller a
bad choice for a reliable setup?

I may not have time to look at this further until late next week, but
I'll follow up with whatever I learn.
