Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUHTSCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUHTSCL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268498AbUHTSCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:02:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:15555 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268483AbUHTSCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:02:06 -0400
X-Authenticated: #1725425
Date: Fri, 20 Aug 2004 20:13:26 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, v13@priest.com
Subject: Re: Possible dcache BUG
Message-Id: <20040820201326.23cf62bb.Ballarin.Marc@gmx.de>
In-Reply-To: <200408201329.05176.gene.heskett@verizon.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<200408201106.15117.gene.heskett@verizon.net>
	<200408201843.23222.v13@priest.com>
	<200408201329.05176.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 13:29:05 -0400
Gene Heskett <gene.heskett@verizon.net> wrote:

> 
> I tried disabling it in the bios and the machine became unusable for 
> all practical purposes. 

Is ECC checking for L2 cache enabled in your BIOS?

BTW: I trimmed the CC list somewhat

Regards
