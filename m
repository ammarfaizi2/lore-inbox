Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbUJXT5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbUJXT5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 15:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbUJXT5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 15:57:10 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:2529 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261235AbUJXT5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 15:57:05 -0400
Subject: New Methodology for SCSI BK trees
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Cc: Douglas Gilbert <dougg@torque.net>, viro@parcelfarce.linux.theplanet.co.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Oct 2004 15:56:47 -0400
Message-Id: <1098647814.10908.244.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, since we're going to be doing another round of
-rc-but-I-dont-really-mean-it, I've set up two scsi bk trees.

bk://linux-scsi.bkbits.net/scsi-rc-fixes-2.6

for fixes which I'll try and merge into -rc candidates

and

bk://linux-scsi.bkbits.net/scsi-misc-2.6

for everything else that will wait until 2.6.10 is released.

Andrew, could you add both these to -mm, please?

For the rc-fixes tree, I'm going to try to guess when linus moves to
-rc-and-I-really-mean-it and at that point I'll only accept critical bug
fixes into this tree (probably I'll tighten up submission policy
gradually as time goes by).

Also, I've gained a web page at

http://www.parisc-linux.org/~jejb/scsi_diffs

Where I'll place the diffs and changelogs corresponding to the scsi
trees for those who want to play with the updates without using BK.

James


