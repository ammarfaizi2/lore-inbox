Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267744AbUG3RBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267744AbUG3RBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267749AbUG3RBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:01:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63192 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267746AbUG3RBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:01:20 -0400
Date: Fri, 30 Jul 2004 12:56:13 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, Roger Luethi <rl@hellgate.ch>
Subject: Re: List of pending v2.4 kernel bugs
Message-ID: <20040730155613.GD2748@logos.cnet>
References: <20040720142640.GB2348@dmt.cyclades> <20040721112336.GA9537@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721112336.GA9537@k3.hellgate.ch>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 01:23:36PM +0200, Roger Luethi wrote:
> On Tue, 20 Jul 2004 11:26:40 -0300, Marcelo Tosatti wrote:
> > I've created a directory to store known pending v2.4 problems,
> > at http://master.kernel.org/~marcelo/pending-2.4-issues/ 
> 
> Multicast is still broken for big-endian architectures using via-rhine
> (2.4.27-rc3). MC use on BE is rare (no bug reports!), but the bug is
> fatal for anyone trying that combination. Jeff's got the patch.
> 
> A couple other drivers may be affected by the same thinko as well.

Hi Roger,

I have added your comments in "multicast-bigendian-netdriver" entry 
in the pending bug list.

I asked Jeff about this but he ignored me, again.

Thanks!

