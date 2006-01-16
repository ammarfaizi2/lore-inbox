Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWAPWPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWAPWPD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWAPWPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:15:03 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:59129 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751180AbWAPWPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:15:02 -0500
Date: Mon, 16 Jan 2006 15:15:01 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mikado <mikado4vn@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is kgdb for kernel 2.6.13 compatible with 2.6.14.5
Message-ID: <20060116221501.GD4662@smtp.west.cox.net>
References: <20060112021056.45798.qmail@web53713.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112021056.45798.qmail@web53713.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 06:10:56PM -0800, Mikado wrote:

> Hi,
> 
> kgdb: http://kgdb.linsyssoft.com/
> 
> I see that the lastest kgdb only support kernel 2.6.13. Is it compatible with kernel 2.6.14.6 or
> 2.6.15?

No, but the release for 2.6.14 is compatible with 2.6.14.  For 2.6.15
you'll have to use CVS (I'm not happy about SMP stability right now, so I
won't be making a 2.6.15 release specifically).

-- 
Tom Rini
http://gate.crashing.org/~trini/
