Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUDWVgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUDWVgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUDWVgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:36:14 -0400
Received: from twin.uoregon.edu ([128.223.214.27]:54668 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S261497AbUDWVgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:36:10 -0400
Date: Fri, 23 Apr 2004 14:36:02 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Timothy Miller <miller@techsource.com>
cc: Paul Jackson <pj@sgi.com>, <tytso@mit.edu>, <miquels@cistron.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: File system compression, not at the block layer
In-Reply-To: <4089875F.1010207@techsource.com>
Message-ID: <Pine.LNX.4.44.0404231434250.27087-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004, Timothy Miller wrote:

> 
> 
> Joel Jaeggli wrote:
> > On Fri, 23 Apr 2004, Paul Jackson wrote:
> > 
> > 
> >>>SO... in addition to the brilliance of AS, is there anything else that 
> >>>can be done (using compression or something else) which could aid in 
> >>>reducing seek time?
> >>
> >>Buy more disks and only use a small portion of each for all but the
> >>most infrequently accessed data.
> > 
> > 
> > faster drives. The biggest disks at this point are far slower that the 
> > fastest... the average read service time on a maxtor atlas 15k is like 
> > 5.7ms on 250GB western digital sata, 14.1ms, so that more than twice as 
> > many reads can be executed on the fastest disks you can buy now... of 
> > course then you pay for it in cost, heat, density, and controller costs. 
> > everthing is a tradeoff though.
> 
> 
> I had this idea of packing a bunch of those really tiny Toshiba 
> quarter-sized drives and some sort of RAID0 controller into a box the 
> size of a 3.5" hard drive.

they're deathly slow... I'll send you an hdparm from an 4GB ibm microdrive 
the next time I have it mounted...
 
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu    
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2


