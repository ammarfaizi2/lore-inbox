Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265110AbUFRLV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbUFRLV7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 07:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUFRLV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 07:21:59 -0400
Received: from lakermmtao07.cox.net ([68.230.240.32]:32656 "EHLO
	lakermmtao07.cox.net") by vger.kernel.org with ESMTP
	id S265110AbUFRLVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 07:21:47 -0400
In-Reply-To: <1087549710.1547.14.camel@newt>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMKAA.davids@webmaster.com> <5b18a542040616133415bf54d1@mail.gmail.com> <20040616224949.GB7932@hh.idb.hist.no> <1087549710.1547.14.camel@newt>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AC6DE22A-C119-11D8-9A43-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       Erik Harrison <erikharrison@gmail.com>, davids@webmaster.com,
       Helge Hafting <helgehaf@aitel.hist.no>, eric@cisu.net
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: more files with licenses that aren't GPL-compatible
Date: Fri, 18 Jun 2004 07:21:41 -0400
To: Adrian Cox <adrian@humboldt.co.uk>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 18, 2004, at 05:08, Adrian Cox wrote:
> USB serial drivers could be implemented in userspace given a 2.6  
> version
> of Rogier Wolff's userspace serial patch:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0303.1/att-1075/01- 
> patch-2.4.20.trueport-12-mrt

I'd rather not. I use my USB serial device for a boot console, support  
for which is currently
in 2.6.  With userspace USB serial drivers I would need to wait for  
userspace to come up,
useless if I want to watch boot output.

Cheers,
Kyle Moffett


