Return-Path: <linux-kernel-owner+w=401wt.eu-S1751165AbXAIIL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbXAIIL1 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 03:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbXAIIL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 03:11:27 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49702
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751156AbXAIIL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 03:11:26 -0500
Date: Tue, 09 Jan 2007 00:11:26 -0800 (PST)
Message-Id: <20070109.001126.133912801.davem@davemloft.net>
To: yoshfuji@linux-ipv6.org
Cc: craig@codefountain.com, komurojun-mbn@nifty.com, bunk@stusta.de,
       jgarzik@pobox.com, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] Re: [BUG KERNEL 2.6.20-rc1] ftp: get or put stops
 during file-transfer
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070109.142244.31020926.yoshfuji@linux-ipv6.org>
References: <20070109.102453.32711440.yoshfuji@linux-ipv6.org>
	<20070109051139.GA2229@craigdell.detnet.com>
	<20070109.142244.31020926.yoshfuji@linux-ipv6.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Date: Tue, 09 Jan 2007 14:22:44 +0900 (JST)

> Dave, please apply.  Thank you.
> 
> In article <20070109051139.GA2229@craigdell.detnet.com> (at Tue, 9 Jan 2007 07:11:39 +0200), Craig Schlenter <craig@codefountain.com> says:
> 
> > All credit goes to Komuro <komurojun-mbn@nifty.com> for tracking
> > this down. The patch is untested but it looks *cough* obviously
> > correct.
> > 
> > Signed-off-by: Craig Schlenter <craig@codefountain.com>
> Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

Applied, thanks everyone.
