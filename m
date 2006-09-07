Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751807AbWIGDJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbWIGDJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 23:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWIGDJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 23:09:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31937 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751807AbWIGDJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 23:09:13 -0400
Date: Wed, 6 Sep 2006 20:08:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Keith Mannthey <kmannth@us.ibm.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: 2.6.18-rc5-mm1
Message-Id: <20060906200824.4f74f221.akpm@osdl.org>
In-Reply-To: <44FEFD6F.4020203@gmail.com>
References: <20060901015818.42767813.akpm@osdl.org>
	<44F86282.9010809@gmail.com>
	<200609051016.40468.bjorn.helgaas@hp.com>
	<44FEFD6F.4020203@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2006 18:55:11 +0200
Maciej Rutecki <maciej.rutecki@gmail.com> wrote:

> Bjorn Helgaas napisał(a):
> > 
> > This ACPI "unknown exception code" problem is the same one reported here:
> >   http://www.mail-archive.com/linux-acpi%40vger.kernel.org/msg02873.html
> > 
> > Basically, we just need to revert this:
> >   http://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/hot-add-mem-x86_64-acpi-motherboard-fix.patch
> > 
> Thanks it works.
> 

So...  should I drop that patch?
