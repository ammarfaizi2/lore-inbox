Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVANMlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVANMlc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 07:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVANMlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 07:41:32 -0500
Received: from static-162-83-93-166.fred.east.verizon.net ([162.83.93.166]:34499
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S261970AbVANMlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 07:41:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16871.48626.40973.996123@ccs.covici.com>
Date: Fri, 14 Jan 2005 07:41:22 -0500
From: John covici <covici@ccs.covici.com>
To: Helge Hafting <helge.hafting@hist.no>
Cc: David Lang <dlang@digitalinsight.com>, John covici <covici@ccs.covici.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10 dies when X tries to initialize PCI radeon 9200 SE
In-Reply-To: <41E7A088.4010708@hist.no>
References: <41E64DAB.1010808@hist.no>
	<16870.21720.866418.326325@ccs.covici.com>
	<Pine.LNX.4.60.0501131820230.20576@dlang.diginsite.com>
	<41E7A088.4010708@hist.no>
X-Mailer: VM 7.17 under Emacs 21.3.50.2
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an apg card and it happens on that one as well.  How can I turn
off drm -- just not load the dri module?

on Friday 01/14/2005 Helge Hafting(helge.hafting@hist.no) wrote
 > David Lang wrote:
 > 
 > > I ran into a similar problem with 2.6.8.1 and found that by 
 > > downgrading to AGP4 I could get it to work.
 > 
 > It can't be AGP because it is a PCI card.
 > Unless something is so broken as to mess with
 > AGP when dealing with a PCI card, that is.  I have an
 > AGP card too in this machine.
 > 
 > Helge Hafting

-- 
         John Covici
         covici@ccs.covici.com
