Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271803AbTGRQVb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268548AbTGRQTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:19:31 -0400
Received: from gw.uk.sistina.com ([62.172.100.98]:8979 "EHLO gw.uk.sistina.com")
	by vger.kernel.org with ESMTP id S271871AbTGRQR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:17:57 -0400
Date: Fri, 18 Jul 2003 17:32:52 +0100
From: Alasdair G Kergon <agk@uk.sistina.com>
To: linux-kernel@vger.kernel.org
Subject: LVM 2.0/Device-Mapper 1.0 available at ftp.sistina.com
Message-ID: <20030718173252.H31325@uk.sistina.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                          *** ANNOUNCEMENT ***

         LVM 2.0/Device-Mapper 1.0 available at ftp.sistina.com
	             for kernels 2.4.20 and 2.4.21

Highlights
~~~~~~~~~~

o Support for online data relocation (pvmove)

o New metadata display tools with a configurable column-based output
  (pvs, vgs, lvs)

o New format for LVM metadata providing enhanced resilience

o Tools can also use LVM1 metadata

o Conversion between LVM1 and LVM2 metadata formats to
  enable in-place migration of existing LVM1 volume groups

o New metadata backup format that is human-readable

o Configuration file for specifying which devices LVM may use, logging 
  levels and more

o Arbitrary extension of striped logical volumes (beyond LVM1 limits)

o Removal of the 256 Logical Volume limit per system (multiple dynamic
  major numbers)


The port of the snapshot and pvmove functionality to Linux 2.6 is underway
and will be available soon.


Please retrieve the tarballs for Device-Mapper and LVM using the
following URLS:

ftp://ftp.sistina.com/pub/LVM2/tools/LVM2.0-stable.tgz
ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper-stable.tgz

Please use the linux-lvm@sistina.com mailing list for feedback.

Thanks a lot for your support of LVM.

Regards,
The LVM development team

