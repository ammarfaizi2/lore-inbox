Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbUBDUwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266589AbUBDUuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:50:21 -0500
Received: from devil.servak.biz ([209.124.81.2]:63705 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S266591AbUBDUst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:48:49 -0500
Subject: RE: Kernel 2.x POSIX Compliance/Conformance...
From: Torrey Hoffman <thoffman@arnor.net>
To: "Randazzo, Michael" <RANDAZZO@ddc-web.com>
Cc: "'Valdis.Kletnieks@vt.edu'" <Valdis.Kletnieks@vt.edu>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16F38@DDCNYNTD>
References: <89760D3F308BD41183B000508BAFAC4104B16F38@DDCNYNTD>
Content-Type: text/plain
Message-Id: <1075927877.3225.73.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 04 Feb 2004 12:51:17 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 12:18, Randazzo, Michael wrote:
> Where are the kernel calls defined for locks and semaphores?
> 
> How come the kernel headers don't define Posix.4 
> semaphores (_POSIX_SEMAPHROES) or Posix itself
> (_POSIX_VERSION is undefined)
> 

I think you need to read "Linux Device Drivers".  If you don't want to
buy it, you can read it for free online.

http://www.xml.com/ldd/chapter/book/

Chapter 9, pages 284-286 discusses locking and atomic operations.


-- 
Torrey Hoffman <thoffman@arnor.net>

