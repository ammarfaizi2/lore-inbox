Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTDUWZD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTDUWZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:25:03 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:64476 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262671AbTDUWZB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 18:25:01 -0400
Date: Mon, 21 Apr 2003 18:37:04 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
In-Reply-To: <20030422002556.A31329@lst.de>
Message-ID: <Pine.LNX.4.55.0304211835180.3658@marabou.research.att.com>
References: <20030421195847.A28684@lst.de> <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
 <20030421210020.A29421@lst.de> <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
 <20030421215637.A30019@lst.de> <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
 <20030421225704.A30489@lst.de> <Pine.LNX.4.55.0304211709560.2913@marabou.research.att.com>
 <20030421232348.A30621@lst.de> <Pine.LNX.4.55.0304211732580.3093@marabou.research.att.com>
 <20030422002556.A31329@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003, Christoph Hellwig wrote:

> This one ontop should really fix it...
>
> (fingers crossed..)

Yes!  /dev/pts is OK.  /dev/vc is OK.  /dev/tts is OK.

Thank you very much!

-- 
Regards,
Pavel Roskin
