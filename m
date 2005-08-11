Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVHKJvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVHKJvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 05:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVHKJvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 05:51:04 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:56996 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932351AbVHKJvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 05:51:03 -0400
Date: Thu, 11 Aug 2005 11:54:24 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Philipp Matthias Hahn <pmhahn@titan.lahn.de>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org
Message-ID: <20050811095424.GA29476@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
	linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org> <20050811064217.GB21395@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050811064217.GB21395@titan.lahn.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.234.60
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2005 Philipp Matthias Hahn wrote:
> PS: MAINTAINTER lists http://linuxtv.org/developer/dvb.xml which is
> dead.

Thanks for reporting.

---
Fix DVB URL.

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

Index: linux-2.6.13-rc6/MAINTAINERS
===================================================================
--- linux-2.6.13-rc6.orig/MAINTAINERS	2005-08-11 11:20:49.000000000 +0200
+++ linux-2.6.13-rc6/MAINTAINERS	2005-08-11 11:23:18.000000000 +0200
@@ -784,7 +784,7 @@ DVB SUBSYSTEM AND DRIVERS
 P:	LinuxTV.org Project
 M: 	linux-dvb-maintainer@linuxtv.org
 L: 	linux-dvb@linuxtv.org (subscription required)
-W:	http://linuxtv.org/developer/dvb.xml
+W:	http://linuxtv.org/
 S:	Supported
 
 EATA-DMA SCSI DRIVER
