Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbUDZOcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbUDZOcH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbUDZOcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:32:07 -0400
Received: from reverendtimms.isu.mmu.ac.uk ([149.170.192.65]:18387 "EHLO
	reverendtimms.isu.mmu.ac.uk") by vger.kernel.org with ESMTP
	id S262996AbUDZOcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 10:32:05 -0400
From: David Johnson <dj@david-web.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Anyone got aic7xxx working with 2.4.26?
Date: Mon, 26 Apr 2004 15:32:37 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404261532.37860.dj@david-web.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering if anyone had aic7xxx SCSI working with kernel 2.4.26?

It doesn't work on my Alpha (hangs the machine on boot) and I'm trying to find 
out whether its an Alpha-specific issue or not, as I can't try the card in 
another machine as it's in production.

I've also got the same problem with 2.6.5 (and newer) - but I think this is a 
known issue with 2.6?

Thanks,
David.

-- 
David Johnson
http://www.david-web.co.uk/
