Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268201AbTGLSKw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 14:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbTGLSKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 14:10:52 -0400
Received: from haw-66-102-130-200.vel.net ([66.102.130.200]:37090 "HELO
	mx100.mysite4now.com") by vger.kernel.org with SMTP id S268201AbTGLSKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 14:10:51 -0400
From: Udo Hoerhold <maillists@goodontoast.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: hard lockups with 2.5.75
Date: Sat, 12 Jul 2003 14:25:29 -0400
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307121425.29939.maillists@goodontoast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I switched from 2.5.73 to 2.5.75 yesterday, and I've encountered three hard 
lockups in the 24 hours I've been running the new kernel.  When I reset the 
machine, I don't see anything unusual in the logs.

The machine is a dual PIII with aic7899 SCSI and 3c905c network on the 
motherboard.  In all three cases where I locked up, there was network and 
disk IO going on.  I don't really have any more info.

If anyone would like to give me a list of things to try, I'd be happy to do 
some testing.

Udo

