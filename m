Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWFTPP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWFTPP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWFTPP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:15:27 -0400
Received: from [212.33.166.67] ([212.33.166.67]:51463 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751305AbWFTPP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:15:26 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: VIA/S3 UniChrome FrameBuffer device
Date: Tue, 20 Jun 2006 18:16:02 +0300
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200606201816.02580.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After crawling the internet, I found the VIA/S3 UniChrome fbdev 
(Linux-FBDev-kernel-src_2.6.00.02) to be sufficiently stable, when 
initialized as a loadable module, un-accelerated and bpp=16.

Any reason it cannot be merged into mainline?

Thanks!

--
Al


