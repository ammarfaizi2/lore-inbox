Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbTISBAG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 21:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTISBAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 21:00:06 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:13818 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S262240AbTISBAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 21:00:02 -0400
Date: Thu, 18 Sep 2003 18:57:55 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: markw@osdl.org, linux-kernel@vger.kernel.org, linstab@osdl.org
Subject: Re: [Linstab] Hackbench STP Results History for 2.5 mm/2.6 mm
Message-ID: <20030918185755.D26428@schatzie.adilger.int>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, markw@osdl.org,
	linux-kernel@vger.kernel.org, linstab@osdl.org
References: <200309190012.h8J0ClU15905@mail.osdl.org> <20030918170754.6164e770.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030918170754.6164e770.akpm@osdl.org>; from akpm@osdl.org on Thu, Sep 18, 2003 at 05:07:54PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 18, 2003  17:07 -0700, Andrew Morton wrote:
> markw@osdl.org wrote:
> >
> > More history from hackbench from STP from the 2.5 and 2.6 mm kernels.
> 
> This looks great, but tragically incomprehensible.
> 
> Could someone please provide some interpretation, tell us what hackbench
> is, and what all the numbers mean?
> 
> Do we rock or do we suck?

I was wondering that also, until I noticed the description at the end.
We should keep the test description at the start, or people lose interest
too quickly ;-)

> markw@osdl.org wrote:
> > The 'Metric' is the average time in seconds to do something with 100
> > processes.  Smaller numbers are better as well as a (-) change.
> > 'Change' refers to a percentage change in the metric from the last
> > completed test with results.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

