Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWDTWUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWDTWUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 18:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWDTWUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 18:20:23 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:30103 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932082AbWDTWUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 18:20:21 -0400
Date: Fri, 21 Apr 2006 00:19:59 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Hua Zhong <hzhong@gmail.com>
cc: "'Mikado'" <mikado4vn@gmail.com>,
       "'linux-os (Dick Johnson)'" <linux-os@analogic.com>,
       "'Linux kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Which process is associated with process ID 0 (swapper)
In-Reply-To: <004801c664c7$e80acfd0$853d010a@nuitysystems.com>
Message-ID: <Pine.LNX.4.61.0604210019440.28841@yvahk01.tjqt.qr>
References: <004801c664c7$e80acfd0$853d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Swapper is the idle process, which swaps nothing. Its name is historic and it doesn't appear in /proc because for_each_process()
>skips it.
>
Anyone objecting to renaming it?


Jan Engelhardt
-- 
