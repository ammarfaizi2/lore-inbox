Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVCWX1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVCWX1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVCWX1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:27:07 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:7172 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262095AbVCWX1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:27:01 -0500
Date: Thu, 24 Mar 2005 00:26:56 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, cmm@us.ibm.com, andrea@suse.de,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: OOM problems on 2.6.12-rc1 with many fsx tests
Message-ID: <20050323232656.GA5704@pclin040.win.tue.nl>
References: <20050315204413.GF20253@csail.mit.edu> <20050316003134.GY7699@opteron.random> <20050316040435.39533675.akpm@osdl.org> <20050316183701.GB21597@opteron.random> <1111607584.5786.55.camel@localhost.localdomain> <20050323144953.288a5baf.akpm@osdl.org> <17250000.1111619602@flay> <20050323152055.6fc8c198.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323152055.6fc8c198.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 03:20:55PM -0800, Andrew Morton wrote:

> Nothing beats poking around in a dead machine's guts with kgdb though.

Everyone his taste.

But I was surprised by

> SwapTotal:     1052216 kB
> SwapFree:      1045984 kB

Strange that processes are killed while lots of swap is available.

Andries
