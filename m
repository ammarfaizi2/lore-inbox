Return-Path: <linux-kernel-owner+w=401wt.eu-S1161251AbXAMDd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbXAMDd5 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161250AbXAMDd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:33:56 -0500
Received: from uni.ns666.com ([202.67.154.148]:57818 "EHLO ns666.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1161238AbXAMDdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:33:55 -0500
X-Greylist: delayed 1749 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 22:33:55 EST
Message-ID: <45A84ACB.5010904@ns666.com>
Date: Sat, 13 Jan 2007 03:58:19 +0100
From: Von Wolher <trilight@ns666.com>
User-Agent: Caprica/7
X-Accept-Language: en-us
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.19.1 failing
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just build a 2.6.19.1 vanilla kernel based on the previous config
(make oldconfig) but for some reason it is not starting. Despite
following the usual procedure with lilo like many times before it seems
that lilo tries to boot it and jumps back to the menu screen.

But selecting the old kernel boots just fine.

Any one can advise on what could cause such behaviour beside the obvious
 steps like did i run lilo after kernel compile, check paths ...

Thanks

Mark
