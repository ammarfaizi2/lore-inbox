Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUJXS3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUJXS3f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbUJXS3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:29:34 -0400
Received: from bender.bawue.de ([193.7.176.20]:56735 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261582AbUJXS30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:29:26 -0400
Date: Sun, 24 Oct 2004 20:29:18 +0200
From: Joerg Sommrey <jo175@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Bug? Load avg 2.0 when idle.
Message-ID: <20041024182918.GA12532@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo175@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there is a load average of 2.0+ even if the box is almost idle. (i.e. "top"
shows just one running process: top itself.) Starting two cpu-intensive
processes raises the load average to 4.0+.  How can I determine the
source for the high load, or is this a bug?
I'm running 2.6.9 on a dual-athlon box.

Thanks,
-jo

-- 
-rw-r--r--  1 jo users 63 2004-10-24 19:38 /home/jo/.signature
