Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266367AbTGEPm1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 11:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266369AbTGEPm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 11:42:27 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:45069 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S266367AbTGEPm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 11:42:26 -0400
Date: Sat, 5 Jul 2003 17:40:32 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANN] 2.4.x snapshots started
Message-ID: <20030705154032.GA9428@alpha.home.local>
References: <3F06D2ED.8080904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F06D2ED.8080904@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 05, 2003 at 09:30:21AM -0400, Jeff Garzik wrote:
> Just like 2.5.x, nightly snapshots of Marcelo's latest 2.4.x BK 
> repository are being posted on kernel.org:
> 
> ftp://ftp.??.kernel.org/pub/linux/kernel/v2.4/snapshots/
> 
> I created the first snapshot midday as a test, and the standard cron job 
> created a second one, so the current release is 2.4.21-bk2.

Jeff, in -bk2, only EXTRAVERSION got changed in Makefile, so the complete
name is now 2.4.22-bk2. This is because the base kernel was 2.4.22-pre2.

Cheers,
Willy

