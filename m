Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267150AbTAKHya>; Sat, 11 Jan 2003 02:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267152AbTAKHya>; Sat, 11 Jan 2003 02:54:30 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:30482
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267150AbTAKHy2>; Sat, 11 Jan 2003 02:54:28 -0500
Date: Sat, 11 Jan 2003 00:01:05 -0800 (PST)
From: Andre Hedrick <andre@pyxtechnologies.com>
To: Oliver Xymoron <oxymoron@waste.org>, Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: More on Linux and iSCSI [info, not flame :)]
In-Reply-To: <Pine.LNX.4.10.10301102139200.31168-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10301102353000.31168-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oliver et al.

http://downloadfinder.intel.com/scripts-df/filter_results.asp?strOSs=19%2C24%2C39&strTypes=DRV%2CFRM%2CUTL&ProductID=844&OSFullName=&submit=Go%21
http://downloadfinder.intel.com/scripts-df/proc/T8Clearance.asp?url=/4461/eng/Zama2_1.0.8_Linux_42715.tgz&agr=N

This self extracting file contains the firmware and software for the 
upgrading to 0.8 iSCSI specification.

I own this product, and have to install RH 7.1 w/ 2.4.2 kernels to use and
test with it.

How about equal time for all?

Now to be fair, I am not looking to have Intel take any heat.
I have already gotten abused over my issue, and it roles off.

Regards,

Andre Hedrick, CTO & Founder
iSCSI Software Solutions Provider
http://www.PyXTechnologies.com/

PS Thanks for the Advertising Minute!
PSS You are welcome Intel for the Advertising Minute!

On Fri, 10 Jan 2003, Andre Hedrick wrote:

> On Fri, 10 Jan 2003, Oliver Xymoron wrote:
> 
> > On Fri, Jan 10, 2003 at 10:36:50PM -0500, Jeff Garzik wrote:
> > > So I thought I would inject some info into the discussion. :)
> > > 
> > > Oliver Xymoron (and others?) mentioned that one could do iSCSI in
> > > userspace.  Well, Intel has code at
> > > 	http://sourceforge.net/projects/intel-iscsi
> > 
> > The included userspace server is largely proof-of-concept code and
> > could do with a fair amount of rounding out. Things this could use to
> > make it interesting:
> > 
> >  - authentication
> >  - run-time configuration
> >  - ability to serve from files and block devices (MD, LVM, crypto-loop)
> >  - ability to serve from /dev/sgX interfaces with native SCSI (tapes, CDRW..)
> > 
> > Don't know what the state of interop with other initiators is though.
> > 
> > I'll also point out that for many Linux<->Linux purposes, nbd is a workable
> > substitute. 
> 
> You are so correct in the Linux<->Linux model, but remember the other OS
> has the dominate market space.  I have proof of interoperability.  Better
> yet I have performance proof without the ability to control the benchmark
> environment.  IIRC that reference is set at version 6.
> 
> The market space has version 7,8,9,11,12,13,16,18,19 working group
> varitions.  So please anyone who wants to compete, I welcome the
> challenge.  Do not forget the hardware, OS license investments.
> 
> Oh and Intel's Pro1000 T Storage Adaptor is a joy to work with, and you
> all can try to figure it out on your own.  Oh and be sure the take notice
> the list of TOE's that do it sideways.  All OS' mixing between ALL OS' is
> the challenge.
> 
> Do not forget the other dozen or so RFC docs to support the entire
> picture.
> 
> Cheers,
> 
> Andre Hedrick, CTO & Founder 
> iSCSI Software Solutions Provider
> http://www.PyXTechnologies.com/
> 
> PS Thanks for the Advertising Minute!

