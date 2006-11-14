Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966373AbWKNVdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966373AbWKNVdh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966376AbWKNVdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:33:37 -0500
Received: from hera.kernel.org ([140.211.167.34]:20625 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S966373AbWKNVdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:33:36 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: driver support for Chelsio T210 10Gb ethernet in 2.6.x
Date: Tue, 14 Nov 2006 13:33:04 -0800
Organization: OSDL
Message-ID: <20061114133304.36a01d0e@freekitty>
References: <Pine.LNX.4.64.0611131408010.32659@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1163539985 2549 10.8.0.54 (14 Nov 2006 21:33:05 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 14 Nov 2006 21:33:05 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 13:28:38 -0800 (PST)
Chris Stromsoe <cbs@cts.ucla.edu> wrote:

> The in-kernel Chelsio cxgb driver in 2.6.19-rc5 is version 2.1.1 and only 
> supports the N110 and N210 10Gb ethernet boards.  The current driver 
> available from Chelsio[1] is 2.1.4a and supports the T110 and T210 series 
> boards, but is only available against 2.6.16.  Any chance of an update to 
> the in-kernel driver for 2.6.20 to support the T* series cards?
> 
> -Chris
> 
> 1. http://service.chelsio.com/drivers/linux/n210/cxgb-2.1.4a.tar.gz
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Only if they don't try to put TOE support in.

-- 
Stephen Hemminger <shemminger@osdl.org>
