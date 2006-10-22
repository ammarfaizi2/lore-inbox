Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWJVVrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWJVVrt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 17:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWJVVrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 17:47:49 -0400
Received: from ns1.suse.de ([195.135.220.2]:65200 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750701AbWJVVrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 17:47:48 -0400
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org
Subject: make pdfdocs broken in 2.6.19rc2 and needs fixes
Date: Sun, 22 Oct 2006 23:47:42 +0200
User-Agent: KMail/1.9.5
Cc: kernel-janitors@lists.osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610222347.42418.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When you do make pdfdocs  with 2.6.19rc2-git7 you get tons of error 
messages and  then some corrupted PDFs in the end.

Fixing that (I suppose it will just need comment fixes and
should not affect the code) should be a relatively easy task for 
a newbie and  would be useful for the 2.6.19 release.

-Andi
