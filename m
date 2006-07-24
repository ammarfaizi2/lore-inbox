Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWGXUc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWGXUc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 16:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWGXUc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 16:32:28 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:39175 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751277AbWGXUc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 16:32:28 -0400
Date: Mon, 24 Jul 2006 16:31:45 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Subject: Question about Git tree methodology.
Message-Id: <20060724163145.5819ce7d.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Mon, 24 Jul 2006 16:31:54 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Mon, 24 Jul 2006 16:31:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
  I've been playing around with setting up a personal git tree for kernel patches.  I've followed Jeff Garzik's guide, as well as some of the kernel.org docs.  I have no problem setting it up, however I have a question about which method to use for my tree.  Basically I just want to use it as a method of tracking my own trivial patches (and perhaps give maintainers easier access to them).  I've looked through some of the trees on kernel.org for guidance.  
  My issue is, if I do a git clone, I wind up with all the history from the kernel git.  This seems excessive and useless for just tracking my own work.  I could alternatively download the source and init a new tree, but I believe it would make keeping up to date with the kernel.org git more complicated.  
  What method is used by the various trees on kernel.org to deal with this?  Is there a way to use the kernel.org git as a base, but only track my own changes?  

Thanks.

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
kernel1@cyberdogtech.com

