Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263686AbUERWUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263686AbUERWUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 18:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUERWS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 18:18:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38630 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263665AbUERWR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 18:17:29 -0400
Date: Tue, 18 May 2004 23:17:28 +0100
From: Matthew Wilcox <willy@debian.org>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kurt Garloff <garloff@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI updates for 2.6.6
Message-ID: <20040518221728.GK6484@parcelfarce.linux.theplanet.co.uk>
References: <20040518184527.GC4859@tpkurt.garloff.de> <Pine.LNX.4.44.0405182140050.3207-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405182140050.3207-100000@poirot.grange>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2004 at 09:47:56PM +0200, Guennadi Liakhovetski wrote:
> Well, Kurt, thanks for the offer. I am prepared and willing to do the work
> on supporting the driver, but I am, perhaps, not skilled enough to be a
> maintainer of a SCSI LDD. My knowledge of the SCSI protocol and the SCSI
> Linux subsystem is pretty limited. On one hand, the driver is little used,
> so, even if I badly break something it is not likely to cause major
> problems. On the other hand, I would feel more comfortable if, at least at
> the beginning, somebody would review my patches. Besides, it would be a
> good opportunity for me to really learn a bit more about SCSI, SCSI Linux
> driver, BIO,...  oh well...

Don't worry about it.  You'll learn these things in time ...
If Kurt's willing to review your patches when you send them,
that'd be best (but don't necessarily wait for Kurt's ack before applying).

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
