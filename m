Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWHAUAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWHAUAL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbWHAUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:00:10 -0400
Received: from main.gmane.org ([80.91.229.2]:41706 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751643AbWHAUAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:00:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Steve Fox" <drfickle@us.ibm.com>
Subject: 2.6.18-rc3 still breaks IDE for PPC
Date: Tue, 1 Aug 2006 19:59:51 +0000 (UTC)
Message-ID: <eaobrn$nt$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: rchp4.rochester.ibm.com
User-Agent: pan 0.104 ("YES, OK!  I *AM* COMMUNIST SPICE!!!  NOW THAT YOU
	KNOW, I AM VERY TICKLE YOU AND THEN YOU ARE DIE!!!")
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still hitting this issue that I first reported on July 7th [1] with
2.6.18-rc1. Is anyone aware of any patches which fix this? 

creating device nodes .hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt

[1] http://thread.gmane.org/gmane.linux.kernel/423795/focus=424403

-- 

Steve Fox
IBM Linux Technology Center

