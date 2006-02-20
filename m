Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161156AbWBTRoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbWBTRoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWBTRoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:44:07 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:46679 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S1161173AbWBTRoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:44:06 -0500
Mime-Version: 1.0
Message-Id: <a0623090bc01fafbc5685@[192.168.0.12]>
In-Reply-To: <OF994D8D1D.24198E91-ONC125711B.00528887-C125711B.0052E575@de.ibm.com>
References: <OF994D8D1D.24198E91-ONC125711B.00528887-C125711B.0052E575@de.ibm.com>
Date: Mon, 20 Feb 2006 10:43:51 -0700
To: Christoph Raisch <RAISCH@de.ibm.com>, Roland Dreier <rolandd@cisco.com>
From: Stephen Poole <spoole@lanl.gov>
Subject: [openib-general] Re: [PATCH 00/22] [RFC] IBM eHCA InfiniBand 
 adapter driver
Cc: Heiko J Schick <SCHICKHJ@de.ibm.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
       Marcus Eder <MEDER@de.ibm.com>, linuxppc64-dev@ozlabs.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If every open source company was being sued for $3B I think many 
companies would be a bit timid. :-) IBM has been working this issue 
at all levels. It will happen when IBM Legal has figured out all of 
the necessary paths in order to cover any potential law suits. 
Unfortunately, the open source path has been muddied by some folks.

Steve...

At 4:06 PM +0100 2/20/06, Christoph Raisch wrote:
>Roland,
>as you already stated we really have a problem that we're not able to send
>"large" pieces of code to the kernel mailing list.
>It's perfectly ok for us to send patches to the openib.org mailing list and
>svn.
>This is something we still try to resolve with legal.
>So thank you Roland for acting as a proxy here...
>We have the ok to contribute to any ehca related discussion on kernel
>mailing-list and ppc64-mailing list, and are absolutely willing to do so!
>
>Adding a new driver for a complex new hardware isn't the regular linux
>develpment case, especially if there's no base code in linux kernel to
>patch against...
>In our case this patch resulted in 22 postings.
>Some people already noticed that there's still quite some road ahead of
>us... but we're abolutely willing to work that, and we had to start at some
>place.
>Some coments will result in modifications to all files.
>I guess posting 22 new patch files (diff against NIL) each week is sort of
>a DoS attack on the mailing list and we'll end up in peoples spam folders
>pretty quickly...
>So what's the recomended way to proceed here?
>
>
>Gruss / Regards . . . Christoph Raisch
>
>christoph raisch, HCAD teamlead
>
>Roland Dreier wrote on 18.02.2006 01:55:32:
>
>>  Here's a series of patches that add an InfiniBand adapter driver
>>  for IBM eHCA hardware.  Please look it over with an eye towards issues
>>  that need to be addressed before merging this upstream.
>>
>
>_______________________________________________
>openib-general mailing list
>openib-general@openib.org
>http://openib.org/mailman/listinfo/openib-general
>
>To unsubscribe, please visit http://openib.org/mailman/listinfo/openib-general


-- 
Steve Poole (spoole@lanl.gov) 
	Office: 505.665.9662
Los Alamos National Laboratory					Cell: 
505.699.3807
CCN - Special Projects / Advanced Development			Fax: 
505.665.7793
P.O. Box 1663, MS B255
Los Alamos, NM. 87545
03149801S
