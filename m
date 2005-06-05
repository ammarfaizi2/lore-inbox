Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVFEHKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVFEHKP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 03:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVFEHKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 03:10:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:45028 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261499AbVFEHKJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 03:10:09 -0400
Date: Sun, 5 Jun 2005 00:10:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zoltan Boszormenyi <zboszor@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mice do not work on 2.6.12-rc5-git9, -rc5-mm1, -rc5-mm2
Message-Id: <20050605001001.3e441076.akpm@osdl.org>
In-Reply-To: <42A2A657.9060803@freemail.hu>
References: <42A2A0B2.7020003@freemail.hu>
	<42A2A657.9060803@freemail.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi <zboszor@freemail.hu> wrote:
>
> Zoltan Boszormenyi írta:
> > Hi,
> > 
> > $SUBJECT says almost all, system is MSI K8TNeo FIS2R,
> > Athlon64 3200+, running FC3/x86-64. I use the multiconsole
> > extension from linuxconsole.sf.net, the patch does not touch
> > anything relevant under drivers/input or drivers/usb.
> > 
> > The mice are detected just fine but the mouse pointers
> > do not move on either of my two screens. The same patch
> > (not counting the trivial reject fixes) do work on the
> > 2.6.11-1.14_FC3 errata kernel. Both PS2 keyboard on the
> > keyboard and aux ports work correctly.
> 
> The same patch also works on 2.6.12-rc4-mm2, with working mice.
> It seems the bug is mainstream.
> 

Please test an unpatched kernel.
