Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTICM3g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbTICM3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:29:36 -0400
Received: from [62.241.33.80] ([62.241.33.80]:56071 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261982AbTICM3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:29:35 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: "Mehmet Ceyran" <mceyran@web.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Who maintains drivers/sound/i810_audio.c?
Date: Wed, 3 Sep 2003 14:29:01 +0200
User-Agent: KMail/1.5.3
References: <001f01c37215$fe6bc060$0100a8c0@server1>
In-Reply-To: <001f01c37215$fe6bc060$0100a8c0@server1>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031429.01672.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 September 2003 14:22, Mehmet Ceyran wrote:

Hi Mehmet,

> I found and fixed a little bug in the "Intel ICH (i8xx), SiS 7012,
> NVidia nForce Audio or AMD 768/811x" driver (kernel 2.4.23-pre2) that
> occured on my laptop with SiS 7012 onBoard sound and wanted to
> contribute it to the official kernel sources.
> In the maintainers file that came with the kernel I couldn't find the
> maintainer of that particular driver so I'd appreciate if someone lead
> me to the correct mailing list so I can post the bug and my patch to the
> right place.

It seems Alan is maintaining i8xx audio, but Alan is away for 1 year now. 
Anyway, you could send him your patch CC'ing LKML.

ciao, Marc

