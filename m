Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbTJDRTD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 13:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbTJDRTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 13:19:03 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:43925 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id S262679AbTJDRTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 13:19:01 -0400
From: David Woodhouse <dwmw2@infradead.org>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F709B9F.8080607@terra.com.br>
References: <3F709B9F.8080607@terra.com.br>
Message-Id: <1065287778.16005.0.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Sat, 04 Oct 2003 18:16:18 +0100
X-SA-Exim-Mail-From: dwmw2@infradead.org
Subject: Re: [PATCH] memory leak in mtdblock.c found by checker
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-23 at 16:14 -0300, Felipe W Damasio wrote:
> 	Hi David,
> 
> 	Patch against 2.6-test5, which checks the right variable if kmalloc 
> failed.

Applied to CVS. Going to Linus some time soon if he hasn't already got
it. Thanks.

-- 
dwmw2


