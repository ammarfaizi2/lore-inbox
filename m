Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269341AbUIIEqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269341AbUIIEqS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 00:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269343AbUIIEqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 00:46:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:44170 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269341AbUIIEqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 00:46:14 -0400
Date: Wed, 8 Sep 2004 21:44:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Blazejowski <diffie@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4
Message-Id: <20040908214414.4e304a81.akpm@osdl.org>
In-Reply-To: <9dda3492040908214277f3d454@mail.gmail.com>
References: <9dda3492040908214277f3d454@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Blazejowski <diffie@gmail.com> wrote:
>
> IT8212 driver fails to recognize RAID0 setup. The driver is built in
> as module (it8212).
> 

OK, there may be some magic to getting it to work.  Alan will know.

> ...
> 
> Under mm3 kernel, RAID0 was working when using the now dropped iteraid driver.
> 

The patch will still apply - ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm3/broken-out/iteraid.patch

