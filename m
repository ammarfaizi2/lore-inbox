Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVJTSBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVJTSBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 14:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVJTSBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 14:01:30 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:9350 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S932512AbVJTSB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 14:01:29 -0400
Date: Thu, 20 Oct 2005 20:01:19 +0200
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: P@draigBrady.com
Cc: linux-kernel@vger.kernel.org, wim@iguana.be
Subject: Re: [PATCH] fix typo drivers/char/watchdog/w83627hf_wdt.c
Message-ID: <20051020180119.GA31111@ojjektum.uhulinux.hu>
References: <20051020174202.GA30201@ojjektum.uhulinux.hu> <4357D941.4090705@draigBrady.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4357D941.4090705@draigBrady.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Oct 20, 2005 at 06:52:01PM +0100, P@draigBrady.com wrote:
> Oops :)
> 
> I notice also that my name has been
> mangled someplace along the line to "Pdraig".
> Ideally it's Pádraig but I'll settle for Padraig :)
> Can you send the updated patch to Wim (cc'd),
> for merging into the watchdog tree.

Sorry I mangled the inlined patch. Here it comes attached.

(Btw, I think you should use only ascii or utf8)

Signed-off-by: Pozsar Balazs <pozsy@uhulinux.hu>

-- 
pozsy

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="w83627hf_wdt.patch"
Content-Transfer-Encoding: 8bit

--- a/drivers/char/watchdog/w83627hf_wdt.c	2005-10-11 03:19:19.000000000 +0200
+++ b/drivers/char/watchdog/w83627hf_wdt.c	2005-10-20 19:39:01.000000000 +0200
@@ -359,5 +359,5 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Pï¿½draig Brady <P@draigBrady.com>");
-MODULE_DESCRIPTION("w38627hf WDT driver");
+MODULE_DESCRIPTION("w83627hf WDT driver");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

--OXfL5xGRrasGEqWY--
