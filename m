Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUDIQHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 12:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUDIQHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 12:07:49 -0400
Received: from p15112047.pureserver.info ([217.160.169.118]:3259 "EHLO
	mail.wim-media.de") by vger.kernel.org with ESMTP id S261426AbUDIQHs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 12:07:48 -0400
From: Christian Roessner <info@roessner-net.com>
Organization: Roessner Network Solutions
To: linux-kernel@vger.kernel.org
Subject: AM53C974 driver missing in 2.6.5
Date: Fri, 9 Apr 2004 18:07:45 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404091807.48179.info@roessner-net.com>
X-Sagator-Scanner: clamd()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found at Google that the AM53C974 was removed since 2.6.0. My problem is: 
This driver is the only one that ever worked (2.4 kernels) for my TEAC CD 
writer. The tmscsim doesn´t do its job and that has nothing to do with the 
latency thing with SCSI-2.

Is there a chance you could put the AM53C974 back in the kernel? Otherwise I 
will not be able to burn CDs under linux anymore :-(

Thanks for comments in advance

Christian
