Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTEJQbP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTEJQbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:31:15 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:53815 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S264110AbTEJQbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:31:14 -0400
From: Jos Hulzink <josh@stack.nl>
To: Jamie Lokier <jamie@shareable.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Use correct x86 reboot vector
Date: Sat, 10 May 2003 20:47:38 +0200
User-Agent: KMail/1.5
Cc: CaT <cat@zip.com.au>, Andi Kleen <ak@muc.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030510025634.GA31713@averell> <1052578182.16166.6.camel@dhcp22.swansea.linux.org.uk> <20030510161710.GC29271@mail.jlokier.co.uk>
In-Reply-To: <20030510161710.GC29271@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305102047.38662.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 May 2003 18:17, Jamie Lokier wrote:
> Alan Cox wrote:
> > At least some SMP boxes freak if you do a poweroff request on CPU != 0
>
> Power-off works on some SMP boxes?

With ACPI kernels, my Dual PII 333 / Intel 440 LX powers down without pressing 
the button.

Jos
