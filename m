Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752123AbWCCBsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbWCCBsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbWCCBsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:07 -0500
Received: from smtp-3.llnl.gov ([128.115.41.83]:61651 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1752123AbWCCBsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:06 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 0/15] EDAC: various fixes and improvements
Date: Thu, 2 Mar 2006 17:47:45 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021747.45221.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following is a set of 15 EDAC patches.  The patches all apply to
kernel 2.6.16-rc5.  I also have a few other EDAC patches, including an
EDAC driver for Athlon64/Opteron, but I'll post just these patches for
now to avoid flooding the list with too many patches all at once.

Dave
