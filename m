Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbUKTAPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUKTAPu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUKTAMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:12:34 -0500
Received: from mo01.iij4u.or.jp ([210.130.0.20]:43973 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S262812AbUKTAH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 19:07:59 -0500
Date: Sat, 20 Nov 2004 09:07:45 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc2-mm1] fixed PMD_ORDER for MIPS
Message-Id: <20041120090745.4b665abb.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20041119173216.GA11705@linux-mips.org>
References: <20041120010805.1fd04cab.yuasa@hh.iij4u.or.jp>
	<20041119173216.GA11705@linux-mips.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004 18:32:16 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Sat, Nov 20, 2004 at 01:08:05AM +0900, Yoichi Yuasa wrote:
> 
> > This patch is fixed PMD_ORDER for MIPS.
> 
> We already have this in CVS.

I know.
This patch is only for 2.6.10-rc2-mm1.

Thanks,

Yoichi
