Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVCPCWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVCPCWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 21:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVCPCWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 21:22:04 -0500
Received: from main.gmane.org ([80.91.229.2]:28633 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262469AbVCPCWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 21:22:01 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam <kinema@gmail.com>
Subject: console/fbdev/DRM rearchitecture progress?
Date: Wed, 16 Mar 2005 02:19:15 +0000 (UTC)
Message-ID: <loom.20050316T031224-991@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 4.242.177.169 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6) Gecko/20050225 Firefox/1.0.1)
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back on the second of August Jon Smirl posted (http://tinyurl.com/5w2nt) a
synopsis of the plan created at OLS for the rearchitecture of the console, fbdev
and DRM subsystems.  Has any more thought gone into this major rework of the
kernel?

--adam

