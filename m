Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261572AbUK1TEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbUK1TEj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 14:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbUK1TEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 14:04:38 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:22969 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261572AbUK1TEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 14:04:01 -0500
Subject: Re: [2.6 patch] small MCA cleanups (fwd)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Weinehall <tao@acc.umu.se>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101661808.16756.26.camel@localhost.localdomain>
References: <20041124020427.GM2927@stusta.de>
	<20041124075932.GJ28432@khan.acc.umu.se> <1101658435.2426.5.camel@mulgrave>
	 <1101661808.16756.26.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 28 Nov 2004 13:02:26 -0600
Message-Id: <1101668552.2429.10.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-28 at 11:10, Alan Cox wrote:
> On Sul, 2004-11-28 at 16:13, James Bottomley wrote:
> > MCA bus limitations in the original IBM spec, so a lot of the MCA HW I
> > have doesn't work on ordinary MCA busses.  The only standard MCA cards I
> > have are networking ones.

Sure ... I have buslogic SCSI, smc_mca and 3c529, but some of the others
could do with converting to the new MCA API...

James


