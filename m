Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbULZQne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbULZQne (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbULZQne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:43:34 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:17892 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261704AbULZQnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:43:24 -0500
Subject: Re: lease.openlogging.org is unreachable
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041226162727.GA27116@work.bitmover.com>
References: <1104077531.5268.32.camel@mulgrave>
	 <20041226162727.GA27116@work.bitmover.com>
Content-Type: text/plain
Date: Sun, 26 Dec 2004 10:43:13 -0600
Message-Id: <1104079394.5268.34.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-26 at 08:27 -0800, Larry McVoy wrote:
> I suspect that your hostname changes when you disconnect.  Leases are 
> issued on a per host basis.  If you make your hostname constant when
> you unplug it should work.  If it doesn't, let us know.

Well, that's a new one, but no, I have a fixed hostname which dhcp is
forbidden from changing.

James


