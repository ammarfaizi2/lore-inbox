Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbTILC6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 22:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbTILC6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 22:58:39 -0400
Received: from adsl-155-178-217.bct.bellsouth.net ([68.155.178.217]:53305 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id S261485AbTILC6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 22:58:38 -0400
Date: Thu, 11 Sep 2003 23:11:52 -0400
To: linux-kernel@vger.kernel.org
Subject: linux-2.6.0-test3 broken tdfxfb resolution
Message-ID: <20030912031152.GA4089@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Booting 2.6.0-test5 with video=tdfx:1024x768-8@85 doesn't set the 
resolution to 1024x768..

-- 
L1:	khromy		;khromy (at) lnuxlab.ath.cx
