Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161574AbWJDQcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161574AbWJDQcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161558AbWJDQcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:32:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25251 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161574AbWJDQcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:32:43 -0400
Subject: Re: [MIPS] Remove IT8172-based platforms, ITE 8172G and Globespan
	IVR support.
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ralf@linux-mips.org, akpm@osdl.org
In-Reply-To: <200610032059.k93KxdLc018212@hera.kernel.org>
References: <200610032059.k93KxdLc018212@hera.kernel.org>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 17:32:21 +0100
Message-Id: <1159979541.2310.3.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 20:59 +0000, Linux Kernel Mailing List wrote:
> [MIPS] Remove IT8172-based platforms, ITE 8172G and Globespan IVR
> support.

> include/linux/ite_gpio.h                    |   66 

Bad Ralf. No biscuit.

diff --git a/include/linux/Kbuild b/include/linux/Kbuild
index 7d564b6..528d2e0 100644
--- a/include/linux/Kbuild
+++ b/include/linux/Kbuild
@@ -99,7 +99,6 @@ header-y += ipx.h
 header-y += irda.h
 header-y += isdn_divertif.h
 header-y += iso_fs.h
-header-y += ite_gpio.h
 header-y += ixjuser.h
 header-y += jffs2.h
 header-y += keyctl.h

-- 
dwmw2

