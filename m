Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTIISQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbTIISQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:16:04 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:25473 "EHLO
	hades.pp.htv.fi") by vger.kernel.org with ESMTP id S264289AbTIISP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:15:58 -0400
Subject: Re: New ATI FireGL driver supports 2.6 kernel
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Dave Jones <davej@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dennis Freise <Cataclysm@final-frontier.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030909175323.GB932@redhat.com>
References: <001a01c3765b$1f1ad6e0$0419a8c0@firestarter.shnet.org>
	 <20030908225401.GD681@redhat.com>
	 <1063069344.28622.53.camel@dhcp23.swansea.linux.org.uk>
	 <20030909075023.GA8065@redhat.com> <1063129307.777.8.camel@hades>
	 <20030909175323.GB932@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063131362.776.11.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 21:16:02 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-09 at 20:53, Dave Jones wrote:
> On Tue, Sep 09, 2003 at 08:41:47PM +0300, Mika Liljeberg wrote:
>  > > For one it links in the GPL'd nvidia GART module.
>  > Hmm, dunno about that:
>  > $ grep -i license nvidia-agp.c
>  > MODULE_LICENSE("GPL and additional rights");
>  > All the rest seems to be under a BSD style license.
> 
> The 'additional rights' on AGPGART come from the time when
> it was in the XFree86 tree. If anything its dual-license
> GPL & X11.  The problem with 'additional rights' tags in
> drivers is they rarely state what those rights are.

Yeah, it's all wonderfully vague. If there are 'additional rights' I
would expect to see the exact license (or a reference to the license) at
the top of each source file.

	MikaL

