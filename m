Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVCCDYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVCCDYL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 22:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCCDVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 22:21:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:9388 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261442AbVCCDSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 22:18:02 -0500
Date: Wed, 2 Mar 2005 19:17:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050302191740.0d37ff4d.akpm@osdl.org>
In-Reply-To: <200503022114.20214.gene.heskett@verizon.net>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	<42265A6F.8030609@pobox.com>
	<20050302165830.0a74b85c.davem@davemloft.net>
	<200503022114.20214.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> Ditto for the 1394 fixes that have been upstream for at 
>  least a month, maybe more. 

-mm always holds the latest 1394 tree.  So you can run -mm, or just snarf
bk-ieee1394.patch from the broken-out directory.

