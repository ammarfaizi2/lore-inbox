Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVDURtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVDURtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVDURtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:49:35 -0400
Received: from palrel10.hp.com ([156.153.255.245]:56280 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261575AbVDURsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:48:11 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16999.59222.398656.317826@napali.hpl.hp.com>
Date: Thu, 21 Apr 2005 10:48:06 -0700
To: "Luck, Tony" <tony.luck@intel.com>
Cc: <davidm@hpl.hp.com>, <akpm@osdl.org>,
       "Andreas Hirstius" <Andreas.Hirstius@cern.ch>,
       "Bartlomiej ZOLNIERKIEWICZ" <Bartlomiej.Zolnierkiewicz@cern.ch>,
       "Gelato technical" <gelato-technical@gelato.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [Gelato-technical] Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7 and later
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0350B3F4@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0350B3F4@scsmsx401.amr.corp.intel.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 21 Apr 2005 10:41:52 -0700, "Luck, Tony" <tony.luck@intel.com> said:

  Tony> Disk space issues?  A complete git repository of the Linux
  Tony> kernel with all changesets back to 2.4.0 takes just over 3G
  Tony> ... which is big compared to BK, but 3G of disk only costs
  Tony> about $1 (for IDE ... if you want 15K rpm SCSI, then you'll
  Tony> pay a lot more).  Network bandwidth is likely to be a bigger
  Tony> problem.

Ever heard that data is a gas?  My disks always fill up in no time at
all, no matter how big they are.  I agree that network bandwidth is an
bigger issue, though.

  Tony> There's a prototype web i/f at http://grmso.net:8090/ that's
  Tony> already looking fairly slick.

Indeed.  Plus it has a cool name, too.  Thanks for the pointer.

	--david
