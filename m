Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbTJHWnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTJHWnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 18:43:49 -0400
Received: from c-36a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.54]:11904
	"EHLO ford.pronto.tv") by vger.kernel.org with ESMTP
	id S261815AbTJHWnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 18:43:49 -0400
To: linux-kernel@vger.kernel.org
Subject: Software RAID5 with 2.6.0-test
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 09 Oct 2003 00:43:43 +0200
Message-ID: <yw1xoewrfizk.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is software RAID5 stable in Linux 2.6.0-test7?  A while back I tried
running a software RAID5 with a 2.6.0-test kernel, and had to spend
the evening running fsck.  The corruption could have been caused by
something other than the RAID layer.  So, is it considered safe to use
RAID5 in 2.6.0 kernels?  I sort of dislike the try and see approach
with matters like this.

-- 
Måns Rullgård
mru@users.sf.net
