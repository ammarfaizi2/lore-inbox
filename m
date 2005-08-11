Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbVHKUVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVHKUVD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVHKUVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:21:03 -0400
Received: from main.gmane.org ([80.91.229.2]:20182 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932422AbVHKUVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:21:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dick <dm@chello.nl>
Subject: How to put an =?utf-8?b?YXRhX3BpaXg=?= (SATA) harddisk to sleep/standby
Date: Thu, 11 Aug 2005 19:45:28 +0000 (UTC)
Message-ID: <loom.20050811T214109-933@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.57.227.179 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050811 Firefox/1.0.6)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do I put an SATA ata_piix harddisk to sleep?

I've tried blktool, hdparm and sdparm but none seem to work, does it need a
special ioctl or should I patch something?

TIA,
Dick

