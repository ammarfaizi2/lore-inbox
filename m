Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267004AbTGGNCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 09:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267006AbTGGNCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 09:02:13 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40873
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S267004AbTGGNCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 09:02:11 -0400
Subject: Re: kernel oops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1057582393.2034.13.camel@tor.trudheim.com>
References: <1057582393.2034.13.camel@tor.trudheim.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057583643.2743.38.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jul 2003 14:14:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-07 at 13:53, Anders Karlsson wrote:
> Running a compile of kernel 2.4.22-pre3 with FreeS/WAN 2.0.1 patches
> applies generates oops in __free_pages_ok which in turn leads to a
> completely unusable system shortly afterwards.

Can you replicate this without the freeswan patches out of interest ?

