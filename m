Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbUC3N7k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 08:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUC3N7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 08:59:40 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18368 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263657AbUC3N7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 08:59:38 -0500
Date: Mon, 29 Mar 2004 17:36:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Ivan Godard <igodard@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel support for peer-to-peer protection models...
Message-ID: <20040329153606.GA3084@openzaurus.ucw.cz>
References: <048e01c413b3_3c3cae60_fc82c23f@pc21.suse.lists.linux.kernel> <p73y8pm951k.fsf@nielsen.suse.de> <07b501c41502_48bd4d20_fc82c23f@pc21> <20040329011416.591ad315.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329011416.591ad315.ak@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Overall it sounds like your architecture is not very well suited to
> > > run Linux.
> > 
> > We believe we can adopt the Linux protection model (i.e. the 386 protection
> > model) with no more work than any other port to a new architectire (ahem).
> 
> Just FYI - Linux has been ported to several architectures with similar SASOS
> capabilities in hardware (IA64 or ppc64 on iseries) and they have all opted to use 
> an conventional protection model.
> 

It might be actually plus for Ivan: if ia64 and ppc64 benefit from
changes for mill, it makes them more acceptable.
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

