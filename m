Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261691AbTCTSKp>; Thu, 20 Mar 2003 13:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261713AbTCTSKp>; Thu, 20 Mar 2003 13:10:45 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:21715 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S261691AbTCTSKo>; Thu, 20 Mar 2003 13:10:44 -0500
Date: Thu, 20 Mar 2003 13:21:35 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bugs sitting in the NEW state for more than two weeks
Message-ID: <20030320182135.GD1757@Master.Wizards>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <3E79D1AD.5080803@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E79D1AD.5080803@us.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 09:35:25AM -0500, Stacy Woods wrote:
> There are 101 bugs sitting in the NEW state for more than 2 weeks
> that don't appear to have any activity. 48 of these bugs are owned
> by bugme-janitors which are good candidates for anyone to work on.
> Please check the bugs for before working on them to see if they are
> still available.
> 
> Kernel Bug Tracker: http://bugme.osdl.org
> 
> 
...
> 
> 387 Other Other bugme-janitors@lists.osdl.org
> poll on usb device does not return immediatly when device is unplugged
> 
> 388 Other Other bugme-janitors@lists.osdl.org
> 2.5.60/ioctl on usb device returns wrong length
> 
> 390 Other Other bugme-janitors@lists.osdl.org
> System hang with MySql workload
...

389 is still in "new" state but doesn't appear in list

...
 
> 
> 410  Platform   i386       mbligh@aracnet.com
> unexpected IO-APIC, please file a report at http://bugzilla.kernel.org
> 
> 415  Drivers    Video(DR   bugme-janitors@lists.osdl.org
> aty128fb.c fails to compile (logic error)
> 
> 417  File Sys   ext3       akpm@digeo.com
> htree much slower than regular ext3
...

413 is still in "new" state but does not appear in list

it seems your script is sorting by more than just age.

If severity "normal" means "ignore" it should be indicated - I'll start 
claiming a higher level.

-- 
Murray J. Root

