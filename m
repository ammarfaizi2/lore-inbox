Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVCVUXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVCVUXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVCVUXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:23:12 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:1271 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261899AbVCVUWi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:22:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=joXm0WwR/n474litlY4GtNPXFYKYPSojmWi2WQrJgsReIybddim/o3t/GoW7w/8l9wYzAfmfy/cLClIvb3JIP4KFUefVqfVDNaasDRsoUVUjCTv9qQKSndR6AhdTK+wVCrmmpRRR9ibvnGfZWUgjKuOJ2pdG/3BKiCXE/ZGNvbs=
Message-ID: <cb57165a05032212223f39d4ad@mail.gmail.com>
Date: Tue, 22 Mar 2005 12:22:34 -0800
From: All Linux <allinux@gmail.com>
Reply-To: All Linux <allinux@gmail.com>
To: Brian Waite <waite@skycomputers.com>
Subject: Re: [PATCH] 2.6.12-rc1, ./drivers/base/platform.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200503221332.15068.waite@skycomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <cb57165a050321213210961749@mail.gmail.com>
	 <200503221332.15068.waite@skycomputers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005 13:32:09 -0500, Brian Waite <waite@skycomputers.com> wrote:
> On Tuesday 22 March 2005 00:32, All Linux wrote:
> > It causes problem, as most platform files, for example,
> > arch/ppc/platforms/katana.c, still use the old name without ".". I do
> Mark Greer recently produced a patch for the katana board among other PPC platforms
> to fix this breakage. I'll look for the announcement mail but I recall seeing it a day or two ago.
> 
> Thanks
> Brian
> 
> 
> 
Ok, I will wait for Mark Greer's patch. Thanks.
