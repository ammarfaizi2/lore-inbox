Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267154AbTAKIGP>; Sat, 11 Jan 2003 03:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbTAKIGP>; Sat, 11 Jan 2003 03:06:15 -0500
Received: from waste.org ([209.173.204.2]:4770 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267154AbTAKIGO>;
	Sat, 11 Jan 2003 03:06:14 -0500
Date: Sat, 11 Jan 2003 02:14:40 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Andre Hedrick <andre@pyxtechnologies.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: More on Linux and iSCSI [info, not flame :)]
Message-ID: <20030111081440.GU14778@waste.org>
References: <Pine.LNX.4.10.10301102139200.31168-100000@master.linux-ide.org> <Pine.LNX.4.10.10301102353000.31168-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10301102353000.31168-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 12:01:05AM -0800, Andre Hedrick wrote:
> 
> Oliver et al.
> 
> http://downloadfinder.intel.com/scripts-df/filter_results.asp?strOSs=19%2C24%2C39&strTypes=DRV%2CFRM%2CUTL&ProductID=844&OSFullName=&submit=Go%21
> http://downloadfinder.intel.com/scripts-df/proc/T8Clearance.asp?url=/4461/eng/Zama2_1.0.8_Linux_42715.tgz&agr=N
> 
> This self extracting file contains the firmware and software for the 
> upgrading to 0.8 iSCSI specification.
> 
> I own this product, and have to install RH 7.1 w/ 2.4.2 kernels to use and
> test with it.

Which means, like every other binary module, it's pretty much
worthless. Though I'm guessing that's not the point you're trying to
make.

(For the record, there's not much value in iSCSI NICs, or TCP offload
in general at the moment, except to avoid potential deadlock issues
with trying to do network buffer allocation down in the block layer)

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
