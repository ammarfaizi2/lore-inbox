Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbTF1TCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 15:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbTF1TCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 15:02:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41098
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265337AbTF1TCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 15:02:54 -0400
Subject: Re: bkbits.net is down
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry McVoy <lm@bitmover.com>
Cc: Scott McDermott <vaxerdec@frontiernet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030628031920.GF18676@work.bitmover.com>
References: <20030627145727.GB18676@work.bitmover.com>
	 <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net>
	 <20030627163720.GF357@zip.com.au>
	 <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk>
	 <20030627235150.GA21243@work.bitmover.com>
	 <20030627165519.A1887@beaverton.ibm.com>
	 <20030628001625.GC18676@work.bitmover.com>
	 <20030627205140.F29149@newbox.localdomain>
	 <20030628031920.GF18676@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056827655.6295.22.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jun 2003 20:14:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-28 at 04:19, Larry McVoy wrote:
> bkbits is 45GB of data and growing.  Tapes are completely impractical,
> that's why we have hot spares.

Overhot spares included 8).

Hot spares wont save you always. I've worked at a telco where we lost
all the disks. the hosts and the hot spares to a PSU failure. The
replication has a lot going for it 8)

