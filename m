Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWBXXpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWBXXpL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 18:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWBXXpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 18:45:10 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:12219 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S964796AbWBXXpJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 18:45:09 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: [slightly OT] dvdrecord 0.3.1 -- and yes, dev=/dev/cdrom works ;)
Date: Sat, 25 Feb 2006 00:42:51 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602250042.51677.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly OT, but I think it's about time to work on a solution rather than the 
flamewar. ;)

I've just released dvdrtools 0.3.1 
(http://www.arklinux.org/projects/dvdrtools/). It is a fork of cdrtools that 
(as the name indicates) adds support for writing to DVD-R and DVD-RW disks 
using purely Free Software, that tries to do things the Linux way ("dvdrecord 
dev=/dev/cdrom whatever.iso") without suggesting to use 2.4 kernels or even 
other operating systems, uses a standard make system, is maintained in a 
public svn repository, and does away with a lot of the libc 
functionality-clones found in cdrtools.

There are a lot more things to do to get CD/DVD writing where it should (and 
could) be -- if anyone else is interested in fixing the CD/DVD situation, 
you're more than welcome to join our team.

Best regards,
bero
